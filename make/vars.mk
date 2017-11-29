LINT_ENABLED := 1
LIBRARY :=

APP_OUT_DIRS :=
LIB_JS_FILES :=
LIB_CSS_FILES :=
BUILD_FILES :=
DIST_FILES :=
TARGETS :=
VARS := VARS_FILE MAKEFILES BUILD_FILES BUILD_FILES_MIN \
        DIST_FILES WATCH_FILES APP_OUT_DIRS TARGETS NPM_SCRIPTS

MAKEFILES := Makefile $(wildcard config/*.mk) $(wildcard make/*.mk)
WATCH_FILES := 'config/*' 'make/*' Makefile package.json
MODULE_DIRS := node_modules
