#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT
readonly OUT="${ROOT}/captures"
TEMP=""
APP_PID=""
ACTIVE_MODULE=""

stop_app() {
  if [[ -n "${APP_PID}" ]]; then
    kill -TERM "${APP_PID}" 2>/dev/null || true
    for _ in {1..5}; do
      if ! kill -0 "${APP_PID}" 2>/dev/null; then break; fi
      sleep 1
    done
    kill -KILL "${APP_PID}" 2>/dev/null || true
    wait "${APP_PID}" 2>/dev/null || true
    APP_PID=""
  fi
}

restore_module() {
  if [[ -n "${ACTIVE_MODULE}" ]]; then
    (cd "${ACTIVE_MODULE}" && otelc cleanup) >>"${OUT}/cleanup.txt" 2>&1 || true
    cp "${TEMP}/go.mod" "${ACTIVE_MODULE}/go.mod"
    if [[ -f "${TEMP}/go.sum" ]]; then
      cp "${TEMP}/go.sum" "${ACTIVE_MODULE}/go.sum"
    else
      rm -f "${ACTIVE_MODULE}/go.sum"
    fi
    ACTIVE_MODULE=""
  fi
}

cleanup() {
  local status=$?
  trap - EXIT
  stop_app
  restore_module
  if [[ -n "${TEMP}" ]]; then
    rm -f "${TEMP}/go.mod" "${TEMP}/go.sum" "${TEMP}/main_gen.go"
    rmdir "${TEMP}" || true
  fi
  exit "${status}"
}

backup_module() {
  ACTIVE_MODULE="$1"
  cp "${ACTIVE_MODULE}/go.mod" "${TEMP}/go.mod"
  rm -f "${TEMP}/go.sum"
  if [[ -f "${ACTIVE_MODULE}/go.sum" ]]; then
    cp "${ACTIVE_MODULE}/go.sum" "${TEMP}/go.sum"
  fi
}

main() {
  case "${1:-}" in
  -h | --help)
    printf 'Usage: %s [--]\nCaptures toolchain, directive, and HTTP demos.\n' "$0"
    return
    ;;
  "" | --) ;;
  *)
    printf 'Unknown argument: %s\n' "$1" >&2
    return 2
    ;;
  esac
  for tool in go otelc jq curl python3; do
    command -v "${tool}" >/dev/null || {
      printf 'Missing tool: %s\n' "${tool}" >&2
      return 1
    }
  done
  mkdir -p "${OUT}" "${ROOT}/toolchain/bin" "${ROOT}/hello/bin"
  TEMP="$(mktemp -d)"
  trap cleanup EXIT
  trap 'exit 130' INT
  trap 'exit 143' TERM

  go version >"${OUT}/go-version.txt"
  otelc version --verbose >"${OUT}/otelc-version.txt"
  go help build | grep -A6 -- '-toolexec' >"${OUT}/go-help-toolexec.txt"

  cd "${ROOT}/toolchain"
  go build -o bin/toolexecwrapper ./cmd/toolexecwrapper
  go build -o bin/loginjector ./cmd/loginjector
  go build -a -toolexec="${ROOT}/toolchain/bin/toolexecwrapper" -o bin/demo-wrapped . 2>"${OUT}/toolexec-wrapper.txt"
  grep '^TOOLEXEC: /' "${OUT}/toolexec-wrapper.txt" | awk '{print $2}' | xargs -n1 basename | sort | uniq -c | sort -rn >"${OUT}/toolexec-counts.txt"
  ./bin/loginjector main.go >"${OUT}/loginjector-build.txt"
  mv main.go.generated "${OUT}/main.go.generated"
  cp "${OUT}/main.go.generated" "${TEMP}/main_gen.go"
  go run "${TEMP}/main_gen.go" >"${OUT}/loginjector-run.txt" 2>&1

  backup_module "${ROOT}/toolchain"
  otelc --rules log.otelc.yml go build -o bin/otelc-log . >"${OUT}/otelc-log-build.txt" 2>&1
  ./bin/otelc-log >"${OUT}/otelc-log-run.txt" 2>&1
  restore_module

  cd "${ROOT}/hello"
  backup_module "${ROOT}/hello"
  otelc go build -o bin/hello . >"${OUT}/hello-build.txt" 2>&1
  if [[ -f .otelc-build/matched.json ]]; then
    cp .otelc-build/matched.json "${OUT}/hello-matched.json"
    jq -r '.. | objects | .name // empty' .otelc-build/matched.json | sort -u >"${OUT}/hello-matched.txt"
  fi
  find .otelc-build -name '*.go' >"${OUT}/hello-otelc-build-files.txt"
  local runtime_file work target
  runtime_file="$(find . -name otelc.runtime.go -print -quit)"
  if [[ -n "${runtime_file}" ]]; then cp "${runtime_file}" "${OUT}/otelc.runtime.go.txt"; fi
  work="$(awk -F= '/^WORK=/{v=$2} END{print v}' "${OUT}/hello-build.txt")"
  : >"${OUT}/hello-serverhandler.txt"
  : >"${OUT}/hello-linkname.txt"
  if [[ -n "${work}" && -d "${work}" ]]; then
    target="$(grep -rl --include='*.go' 'OtelBeforeTrampoline_ServeHTTP' "${work}" | head -n 1 || true)"
    if [[ -n "${target}" ]]; then
      grep -A12 'func (sh serverHandler) ServeHTTP(' "${target}" >"${OUT}/hello-serverhandler.txt" || true
    fi
    grep -rh -A1 --include='*.go' 'go:linkname [A-Za-z]*ServeHTTP' "${work}" >"${OUT}/hello-linkname.txt" || true
  fi

  python3 -c 'import socket; s=socket.socket(); s.bind(("localhost",18080)); s.close()'
  OTEL_SERVICE_NAME=hello OTEL_TRACES_EXPORTER=console OTEL_METRICS_EXPORTER=none OTEL_LOGS_EXPORTER=none ./bin/hello >"${OUT}/hello-spans.json" 2>"${OUT}/hello-stderr.txt" &
  APP_PID=$!
  sleep 2
  curl --max-time 10 -sS http://localhost:18080/hello >"${OUT}/hello-curl.txt"
  sleep 6
  stop_app
  jq -s -r '.[] | select(has("SpanContext")) | [.Name, (.SpanKind|tostring), .SpanContext.TraceID[0:8], ((.Parent.SpanID // "") | if test("^0+$") then "—" else .[0:8] end)] | @tsv' "${OUT}/hello-spans.json" >"${OUT}/hello-spans.tsv"
  restore_module
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi
