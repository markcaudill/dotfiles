SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

SHELLCHECK = shellcheck --external-sources --color=always --format=tty
ALL = $(shell git ls-files | grep -vE '.github|LICENSE|Makefile|README.md')
DEST = $(HOME)

all: $(ALL)

shellcheck: $(shell git ls-files "*.bash" "*.sh" | xargs)
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
