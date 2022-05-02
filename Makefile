SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

SHELLCHECK = shellcheck
IGNORE = "(Makefile.*|README\.md|\.github|\.gitlab-ci\.yml|LICENSE)"
STOW = stow -v -t $(DEST) --ignore=$(IGNORE) --no-folding --dotfiles
ALL = $(shell git ls-files | grep -vE $(IGNORE))
DEST = $(HOME)

all: $(ALL)

shellcheck: $(shell grep --exclude-dir=.git -rlE '^#!/.*(sh|bash)' | xargs) $(shell git ls-files .config/bash.d | xargs)
	@echo "+ $@ : $^"
	$(SHELLCHECK) $^
.PHONY: shellcheck

test: shellcheck

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
