# Sources and evidence

Checked on 24 September 2026. otelc source excerpts use tag `v1.1.0` (commit prefix `449ee08`), not a moving branch. Live documentation, community schedules, and release metadata were checked separately.

## Claim ledger

| Claim or material | Source | Accessed |
| --- | --- | --- |
| otelc v1.1.0 released 24 August 2026; v1.0.1 released 14 July 2026 | [v1.1.0 release](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/releases/tag/v1.1.0), [v1.0.1 release](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/releases/tag/v1.0.1) | 2026-09-24 |
| v1.0.0 is retracted because pin generated incorrect module paths | [go.mod at v1.1.0](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/go.mod) | 2026-09-24 |
| Go 1.25+, installation command | [Getting started](https://opentelemetry.io/docs/zero-code/go/compile-time/getting-started/), [tagged README](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/README.md) | 2026-09-24 |
| Application, dependencies, standard library; no runtime agent; roadmap | [v1 announcement](https://opentelemetry.io/blog/2026/go-compile-time-instrumentation-v1/) | 2026-09-24 |
| SIG origin, Alibaba/Datadog/Quesma contributions, quoted collaboration statement | [January 2025 SIG announcement](https://opentelemetry.io/blog/2025/go-compile-time-instrumentation/) | 2026-09-24 |
| Setup/build phases, trampoline design, linkname | [implementation.md](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/docs/implementation.md) | 2026-09-24 |
| Preserved build files, debug logging, cleanup, generic and GLS limitations | [troubleshooting.md](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/docs/troubleshooting.md) | 2026-09-24 |
| Direct GOFLAGS integration, tool dependency, cache separation, pin limitation #585 | [getting-started.md](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/docs/getting-started.md) | 2026-09-24 |
| Compile/link importcfg patching and tool identity | [toolexec.go](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/tool/internal/instrument/toolexec.go) | 2026-09-24 |
| Conditional skeleton, inlining, DCE and SCCP | [optimize.go](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/tool/internal/instrument/optimize.go) | 2026-09-24 |
| Rule schema and all eight modifiers | [rules.md](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/docs/rules.md) | 2026-09-24 |
| Nested lowercase rule names in matched.json | [rule/base.go](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/tool/internal/rule/base.go), [captured JSON](demo/captures/hello-matched.json) | 2026-09-24 |
| net/http server rule | [server/otelc.yaml](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/instrumentation/net/http/server/otelc.yaml) | 2026-09-24 |
| BeforeServeHTTP hook, propagation and map-based hook state | [server_hook.go](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/instrumentation/net/http/server/server_hook.go) | 2026-09-24 |
| SDK init rule and generated init function | [init/otelc.yaml](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/instrumentation/go.opentelemetry.io/otel/init/otelc.yaml), [init_otelsdk.go](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/instrumentation/go.opentelemetry.io/otel/init/init_otelsdk.go) | 2026-09-24 |
| Runtime fields and goroutine propagation rule | [runtime/otelc.yaml](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/instrumentation/runtime/otelc.yaml) | 2026-09-24 |
| Four GLS accessor functions | [runtime_gls.go](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/instrumentation/runtime/runtime_gls.go) | 2026-09-24 |
| Calls to added runtime functions | [demo/app/basic/main.go](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/demo/app/basic/main.go) | 2026-09-24 |
| OTEL variables, console exporter, OTLP HTTP default | [Configuration](https://opentelemetry.io/docs/zero-code/go/compile-time/configuration/), [otel_setup.go](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/pkg/runtime/otel_setup.go), [console capture](demo/captures/hello-spans.json) | 2026-09-24 |
| Supported libraries and default runtime metrics | [Tagged library table](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/docs/getting-started.md#supported-libraries), [docs table](https://opentelemetry.io/docs/zero-code/go/compile-time/supported-libraries/), [SDK init](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/instrumentation/go.opentelemetry.io/otel/init/init_otelsdk.go) | 2026-09-24 |
| Runtime-overhead quotation | [README footnote](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/README.md) | 2026-09-24 |
| Build overhead model and +150% CI regression gate | [benchmarking.md](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/docs/benchmarking.md), [toolexec.go](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation/blob/v1.1.0/tool/internal/instrument/toolexec.go) | 2026-09-24 |
| Thursday 09:30 UTC meeting, Slack, calendar and SIG liaison | [Community schedule](https://github.com/open-telemetry/community#implementation-sigs), [SIG details](https://github.com/open-telemetry/community/blob/main/sigs.md#golang-compile-time-instrumentation) | 2026-09-24 |
| Maintainers and approver, Azhar Momin's LFX participation | [Current README](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation#maintainers), [v1 announcement](https://opentelemetry.io/blog/2026/go-compile-time-instrumentation-v1/) | 2026-09-24 |
| OBI v0.13.0 released 4 September 2026; development status | [Release](https://github.com/open-telemetry/opentelemetry-ebpf-instrumentation/releases/tag/v0.13.0), [support matrix](https://github.com/open-telemetry/opentelemetry-ebpf-instrumentation/blob/main/SUPPORT_MATRIX.md) | 2026-09-24 |
| OBI Linux/BTF/capabilities, languages and instrumentation boundaries | [OBI docs](https://opentelemetry.io/docs/zero-code/obi/), [support matrix](https://github.com/open-telemetry/opentelemetry-ebpf-instrumentation/blob/main/SUPPORT_MATRIX.md) | 2026-09-24 |
| dst keeps comments attached to nodes; go/ast uses source positions | [dst README](https://github.com/dave/dst#readme), [generated toy output](demo/captures/main.go.generated) | 2026-09-24 |
| Go runtime hall-of-shame comment | [runtime/proc.go](https://go.dev/src/runtime/proc.go), [local Go 1.27.1 excerpt](demo/captures/go-runtime-gopark.txt) | 2026-09-24 |
| Linkname variable resolution and load order | [golang/go#72032](https://github.com/golang/go/issues/72032) | 2026-09-24 |
| Profiles specification is Alpha | [Profiles specification](https://opentelemetry.io/docs/specs/otel/profiles/) | 2026-09-24 |
| Speaker roles | [Prometheus governance](https://github.com/prometheus/governance/blob/main/GOVERNANCE.md), [client_golang maintainers](https://github.com/prometheus/client_golang/blob/main/MAINTAINERS.md), [otelc maintainers](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation#maintainers); local gopherconuk-26 research/about-speaker.md evidence ledger | 2026-09-24 |
| Event title, venue, speaker sequence and abstracts | [Event page](https://ocgroups.dev/cncf/group/7qtkpm8/event/24fkh4j); speaker-provided opening slot and duration | 2026-09-24 |
| Java agent download command | [Latest agent artifact](https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar) | 2026-09-24 |
| Original explanation, illustrative manual/AOP panels and speaker notes | [GopherCon UK 2025 source](https://github.com/kakkoyun/public-content/blob/main/presentations/2025/GopherCon%20UK%202025%20-%20Unleashing%20the%20Go%20Toolchain.md); read-only local Obsidian clone | 2026-09-24 |
| Toy source, wrapper and AST injector | [Original demo](https://github.com/kakkoyun/gopherconuk25-demo), [adapted local demo](demo/toolchain) | 2026-09-24 |
| Daniel Martí build-system reference and screenshot | [Deep dive into Go's build system](https://www.youtube.com/watch?v=sTXc_JxmvV0) | 2026-09-24 |
| Abelson quotation and simplicity/debugging framing | Original 2025 slide source above; the “10x” line is the speaker's rhetorical observation, not a measured result | 2026-09-24 |
| Where manual, otelc and OBI fit | Speaker synthesis of the otelc and OBI sources above; not a universal coverage guarantee | 2026-09-24 |

## Capture ledger

All files below are in `demo/captures/`. The build used otelc v1.1.0 and Go 1.27.1 on darwin/arm64. Re-running changes timings, trace identifiers, temporary directories, and tool-call counts.

| Capture | Used for | Accessed |
| --- | --- | --- |
| `go-version.txt`, `otelc-version.txt` | Tool versions | 2026-09-24 |
| `go-help-toolexec.txt` | S34, verbatim Go help | 2026-09-24 |
| `toolexec-wrapper.txt`, `toolexec-counts.txt` | S37/S38, 106 calls: 57 compile, 48 asm, one link | 2026-09-24 |
| `loginjector-build.txt`, `main.go.generated`, `loginjector-run.txt` | S51-S54, actual rewritten code, logs and misplaced comment | 2026-09-24 |
| `otelc-log-build.txt`, `otelc-log-run.txt` | S65/S66, custom directive build and runtime logs | 2026-09-24 |
| `hello-build.txt`, `hello-matched.json`, `hello-matched.txt` | S74/S75, nine named rules in a 39-line application | 2026-09-24 |
| `hello-otelc-build-files.txt`, `otelc.runtime.go.txt` | Generated build artifacts and import setup | 2026-09-24 |
| `hello-serverhandler.txt`, `hello-linkname.txt` | S80/S81, real rewritten net/http and hook declarations | 2026-09-24 |
| `hello-spans.json`, `hello-spans.tsv`, `hello-curl.txt` | S86, three spans with one TraceID; response is hello, world | 2026-09-24 |
| `hello-stderr.txt`, `cleanup.txt` | Empty on successful capture; not slide evidence | 2026-09-24 |
| `go-runtime-gopark.txt` | S117, three lines from local Go runtime source | 2026-09-24 |

Long paths in slide excerpts are abbreviated and tool-command lines are truncated after 90 characters. The full capture files remain available. The 121-line SDK setup and 306-line toy injector counts come from the local files; the SDK setup is an inherited teaching example, not the application's measured initialization cost.

The inherited manual instrumentation and AST/AOP panels are source examples, not execution output. Some omit imports or supporting functions; S19 is explicitly hypothetical. Only the demo programs and their generated output were built and exercised locally. S40 corrects the original return-type typo, and S62 moves span creation before its first use. These are presentation fixes, not changes to the old source deck.

## Preparation corrections and fallbacks

- The supplied directive YAML had an invalid document-level `version`. v1.1.0 treats every top-level key as a rule; `version` is an optional target-version constraint inside a rule. Removing the document-level line made the build succeed. No directive-to-inject_code fallback was needed.
- `matched.json` nests lowercase `name` fields. `.[].Name` returned null; the capture uses `.. | objects | .name // empty` and sorts unique names.
- The console output includes JSON SDK log records as well as spans. The TSV selects records with `SpanContext`; it does not delete genuine span output.
- The net/http hook uses `SetData(map[string]interface{}{...})`, not the `hookData` struct assumed in the plan. The slide follows the tagged source.
- The tagged library table contains Library and Semantic Conventions columns. The deck preserves them and splits the table to fit.
- The planned Go 1.25 fallback was attempted after the first failure, but the local `go` command still reported Go 1.27.1. The final successful run used the default Go 1.27.1. No Go 1.27 incompatibility was established.
- Kroki returned HTTP 500. Mermaid CLI 11 rendered the diagrams locally using installed Chrome after its bundled browser lookup failed.
- ImageMagick needed an explicit font for contact sheets.
- The user removed the GopherCon-specific closing references, including Jon Bodner. The build sequence diagram was then split into compile and link slides because the combined version's text was too small. These two changes leave 117 pages.
- Implementation began at 14:54 CEST, after the original capture cutoff. Captures completed around 15:09. The old Obsidian clone was not modified.

## Upstream documentation differences

These were not changed upstream:

- The otelc README says Thursday 08:00-09:00 UTC; the community schedule says Thursday 09:30 UTC. The slide uses the community schedule.
- The otelc README spells Dario's surname “Castañe”; the deck uses “Castañé”.
- Tagged getting-started docs call the Slack channel `#otel-go-compt-instr-sig`; the community schedule calls the same channel ID `#otel-go-compile-instrumentation`.
- The website's getting-started example points at port 4317, while otelc defaults to OTLP HTTP/protobuf on 4318. The slide makes the HTTP endpoint explicit.
- The planning notes flagged a local comparison draft with older Go-version and metrics claims. That private draft is not evidence for this deck.
- The Marp skill recommends `vcenter`, but the copied theme does not define it. The deck defines it locally and does not modify the canonical theme.
- The parent public-content index checker needs referenced submodules initialized on a fresh clone. Parent integration is a separate publication step.
