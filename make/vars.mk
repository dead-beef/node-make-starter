LINT_ENABLED := 1
LIBRARY :=

BUILD_DIR = build
MIN_DIR := $(BUILD_DIR)/min
DIST_DIR = dist
APP_OUT_JS_DIR := $(DIST_DIR)/js
APP_OUT_CSS_DIR := $(DIST_DIR)/css
BUILD_FILES :=
DIST_FILES :=
TARGETS :=
NPM_SCRIPTS :=
LOAD_MODULES :=
VARS := MODULE_PATH VARS_FILE MAKEFILES BUILD_FILES BUILD_FILES_MIN \
        DIST_FILES WATCH_FILES TARGETS NPM_SCRIPTS

VARS_FILE := $(BUILD_DIR)/vars.mk
MAKEFILES := Makefile $(VARS_FILE) $(wildcard $(MAKEFILE_PATH)/*.mk)
WATCH_FILES := 'config/*' '$(MAKEFILE_PATH)/*' Makefile package.json
MODULE_DIRS := node_modules
MODULE_PATH := $(shell $(NODE) -e 'console.log(module.paths.join(" "))')

-include $(VARS_FILE)

ifneq "$(MAKECMDGOALS)" "install"
$(VARS_FILE): package.json $(MAKEFILE_DIR)/make-vars.js config/override.js | $(BUILD_DIR) $(MODULE_DIRS)
	$(call prefix,vars,$(MAKE_VARS_CMD) >$@.tmp)
	$(call prefix,vars,$(MV) $@.tmp $@)
endif
