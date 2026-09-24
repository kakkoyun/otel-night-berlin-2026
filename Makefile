MARP ?= npx marp
CONTACT_FONT ?= /System/Library/Fonts/Supplemental/Arial.ttf
FLAGS := --config marp/marp.config.js --allow-local-files --theme-set marp/css/

.PHONY: install html pdf watch serve diagrams qr captures contact lint/md check/typos check clean
install:
	npm install
html:
	$(MARP) presentation.md $(FLAGS) -o presentation.html
pdf:
	$(MARP) presentation.md $(FLAGS) --pdf -o presentation.pdf
watch:
	$(MARP) presentation.md $(FLAGS) --watch --preview
serve:
	python3 -m http.server 8000
diagrams:
	mkdir -p assets/diagrams
	@for f in diagrams/*.mmd; do \
		curl -sSf --max-time 60 -X POST -H 'Content-Type: text/plain' --data-binary @$$f https://kroki.io/mermaid/svg -o assets/diagrams/$$(basename $$f .mmd).svg || exit $$?; \
	done
qr:
	qrencode -o assets/qr-talk-repo.png -s 12 -m 2 'https://github.com/kakkoyun/otel-night-berlin-2026'
captures:
	bash demo/capture.sh
contact:
	mkdir -p /tmp/otelnight-sheets
	pdftoppm -r 40 -png presentation.pdf /tmp/otelnight-sheets/p
	montage -font "$(CONTACT_FONT)" /tmp/otelnight-sheets/p-*.png -tile 4x3 -geometry +4+4 /tmp/otelnight-sheets/sheet-%02d.png
lint/md:
	npx markdownlint-cli2 presentation.md README.md SOURCES.md
check/typos:
	typos presentation.md README.md SOURCES.md
check: lint/md check/typos
	test -z "$$(gofmt -l demo)"
	cd demo/toolchain && go vet ./...
	cd demo/hello && go vet ./...
	! grep -Eq 'src="https?://' presentation.html
clean:
	rm -f presentation.html presentation.pdf
