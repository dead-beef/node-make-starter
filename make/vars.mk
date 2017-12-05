LINT_ENABLED := 1
LIBRARY :=

BUILD_DIR = build
MIN_DIR := $(BUILD_DIR)/min
DIST_DIR = dist
APP_OUT_DIRS :=
BUILD_FILES :=
DIST_FILES :=
TARGETS :=
NPM_SCRIPTS :=
VARS := MODULE_PATH VARS_FILE MAKEFILES BUILD_FILES BUILD_FILES_MIN \
        DIST_FILES WATCH_FILES APP_OUT_DIRS TARGETS NPM_SCRIPTS

MAKEFILES := Makefile $(wildcard config/*.mk) $(wildcard make/*.mk)
WATCH_FILES := 'config/*' 'make/*' Makefile package.json
MODULE_DIRS := node_modules
MODULE_PATH := $(shell $(NODE) -e 'console.log(module.paths.join(" "))')
