SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

SHELLCHECK = shellcheck --external-sources --color=always --format=tty
STOW = stow -v -t $(DEST) --ignore="(Makefile.*|README\.md|\.github|LICENSE)"
ALL = $(shell git ls-files | grep -vE '.github|LICENSE|Makefile|README.md')
DEST = $(HOME)

all: $(ALL)

shellcheck: $(shell grep --exclude-dir=.git -rlE '^#!/.*(sh|bash)' | xargs)
	@echo "+ $@ : $^"
	$(SHELLCHECK) $^
.PHONY: shellcheck

test: shellcheck

install: $(ALL)
	@echo "+ $@: $^"
	for i in $^; do
		install -v -D -m $$(stat -c %a $$i) -t $(DEST)/$$(dirname $$i) $$i
	done
.PHONY: install

uninstall: $(ALL)
	@echo "+ $@"
	for i in $^; do
		rm -fv $(DEST)/$$i
	done
.PHONY: uninstall

stow: $(ALL)
	@echo "+ $@"
	$(STOW) -S ./
.PHONY: stow

unstow: $(ALL)
	@echo "+ $@"
	$(STOW) -D ./
.PHONY: unstow

restow: $(ALL)
	@echo "+ $@"
	$(STOW) -R ./
.PHONY: restow
