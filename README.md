# Under the Hood of Compile-Time Instrumentation for Go

| | |
| --- | --- |
| Event | OTel Night Berlin v2026.09: Go Compile-Time Instrumentation |
| Date | Thursday, 24 September 2026 |
| Venue | Sony Interactive Entertainment, Kemperplatz 1, Berlin |
| Slot | Opening talk, 18:00 CEST, 30 minutes including Q&A |
| Speaker | Kemal Akkoyun, OpenTelemetry Go Compile-Time Instrumentation maintainer, Datadog |
| Event page | <https://ocgroups.dev/cncf/group/7qtkpm8/event/24fkh4j> |

Go's build tools provide a place to add instrumentation without editing application code. This talk follows `-toolexec`, AST rewriting, and otelc v1.1.0 through a real HTTP build, then covers where compile-time instrumentation fits and what to check before adopting it.

## Contents

- [Slide source](presentation.md), [HTML presentation](presentation.html), [PDF backup](presentation.pdf).
- [Toolchain demo](demo/toolchain): a build wrapper and a `go/ast` logging injector.
- [HTTP demo](demo/hello): `/hello` calls `/world`, producing one trace with three spans.
- [Captured evidence](demo/captures) and [capture script](demo/capture.sh).
- [Mermaid sources](diagrams), pre-rendered SVGs, and a repository QR in [assets](assets).
- [Sources and implementation findings](SOURCES.md).

There are 117 slides: 111 main slides and six bonus slides. Source-note identifiers retain the original plan's numbering, with S109 removed and S077 split into compile and link diagrams for readability. Notes mark optional slides with `SKIP?` and pacing checkpoints with `⏱`. Aim for about 25 minutes before Q&A; the final checkpoint is a latest-stop reminder, not a rehearsal result.

## Build

Requirements:

- Node.js and npm. This build used Node 26 and the pinned local Marp CLI 4.5.0.
- Go 1.25 or newer; captures here used Go 1.27.1 on macOS arm64.
- otelc v1.1.0, jq, curl, Python 3.
- qrencode, Poppler (`pdftoppm`), ImageMagick (`montage`).
- Google Chrome or another browser supported by Marp for PDF export.
- `typos`, `goimports`, `shellcheck`, and `shfmt` for development checks.

```bash
npm ci
make html pdf
make check
```

The runner used for both exports was **`npx marp`**. No alternate Marp runner was needed. The HTML uses local images and diagrams, with native emoji and no remote `src` attributes. Keep `assets/` beside the HTML when copying it to another machine.

To regenerate supporting assets:

```bash
make qr
make diagrams
make contact
```

`make diagrams` sends these public Mermaid diagrams to Kroki. Kroki returned HTTP 500 during preparation, so the checked-in SVGs were rendered locally with Mermaid CLI 11:

```bash
export PUPPETEER_EXECUTABLE_PATH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
for f in diagrams/*.mmd; do
  npx -y @mermaid-js/mermaid-cli@11 -i "$f" \
    -o "assets/diagrams/$(basename "$f" .mmd).svg" -b transparent
done
```

The installed Chrome path avoids a missing bundled `chrome-headless-shell`. `make contact` writes 4-by-3 sheets to `/tmp/otelnight-sheets/`. It uses an explicit macOS Arial font because ImageMagick's default font lookup failed here; override `CONTACT_FONT` on another platform.

## Present

Open `presentation.html` in Chrome. Press `p` for presenter view with notes and timer, and `f` for fullscreen. Stay on the questions slide during Q&A, then advance to Juraci's handoff. The six bonus slides follow the handoff and are not part of the timed talk.

`presentation.pdf` is the offline backup. For a local HTTP server, run `make serve` and open <http://localhost:8000/presentation.html>. Use `make watch` while editing.

## Reproduce the demos

```bash
go install go.opentelemetry.io/otelc/tool/cmd/otelc@v1.1.0
export PATH="$(go env GOPATH)/bin:$PATH"
make captures
```

The script builds the two toy tools, exercises a `//demo:log` rule, then builds and starts the HTTP application on port 18080. It stops its server and restores each demo's module files on exit. Run it only when that port is free. otelc may download SDK dependencies during setup; this is a version-pinned tool demonstration, not a hermetic dependency benchmark.

Captures are real local outputs from 24 September 2026. Durations, trace IDs, temporary paths, and tool-call counts will vary. The wrapper's build diagnostics can also appear when Go replays cached compiler output; the JSON application lines remain identifiable in `loginjector-run.txt`.

Inherited teaching panels explain partial code and are not all standalone programs. The Python decorator is explicitly hypothetical. The runnable demos are under `demo/toolchain` and `demo/hello`; see the source ledger for the boundary between examples, captures, and pinned upstream excerpts.

## Links

- [otelc repository](https://github.com/open-telemetry/opentelemetry-go-compile-instrumentation)
- [Getting started](https://opentelemetry.io/docs/zero-code/go/compile-time/getting-started/)
- [v1 announcement](https://opentelemetry.io/blog/2026/go-compile-time-instrumentation-v1/)
- [SIG schedule and meeting notes](https://github.com/open-telemetry/community/blob/main/sigs.md#golang-compile-time-instrumentation)

## License

Original material is available under [Apache-2.0](LICENSE). OpenTelemetry excerpts retain their upstream attribution. Logos and the Daniel Martí video screenshot belong to their respective owners and are included as references; this license does not grant rights to those marks or images.
