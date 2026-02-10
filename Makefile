SHELL := /bin/bash

BUNDLE ?= bundle
PROJECT_ROOT := $(abspath .)
BIN_NAME := git-branch-creator
BIN_PATH := $(PROJECT_ROOT)/$(BIN_NAME)
INSTALL_DIR ?= $(HOME)/.local/bin
LINK_PATH := $(INSTALL_DIR)/$(BIN_NAME)

.PHONY: setup symlink test

setup:
	$(BUNDLE) install

symlink:
	mkdir -p "$(INSTALL_DIR)"
	ln -sf "$(BIN_PATH)" "$(LINK_PATH)"
	@echo "Linked $(LINK_PATH) -> $(BIN_PATH)"

test:
	$(BUNDLE) exec rspec spec/
