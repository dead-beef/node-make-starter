LINT_ENABLED = 1
LIBRARY =

APP_NAME = app

APP_DIR = src
BUILD_DIR = build
MIN_DIR := $(BUILD_DIR)/min
DIST_DIR = dist

LIB_NAME = vendor
LIB_FONT_DIRS := node_modules/material-design-icons-iconfont/dist/fonts \
                 node_modules/materialize-css/dist/fonts/roboto
LIB_FONT_DIST_DIRS := material-icons roboto
LIB_FONT_TYPES = %.otf %.eot %.svg %.ttf %.woff %.woff2

HTML_DIRS =
HTML_FILES =

JS_DIRS := $(APP_DIR)/js
JS_IGNORE = %.test.js

JS_FILES := $(foreach d,$(JS_DIRS),$(call rwildcard,$d/,*.js))

CSS_TYPE = scss
CSS_DIRS = $(APP_DIR)/css
CSS_FILES = $(APP_DIR)/css/main.scss
LIB_CSS_FILES := $(APP_DIR)/css/vendor.scss
LIB_CSS_DEPS := $(APP_DIR)/css/_materialize.scss

COPY_DIRS := $(APP_DIR)
COPY_FILE_TYPES = %.jpg %.jpe %.jpeg %.png %.gif %.svg %.ico %.html
COPY_FILE_TYPES_WILDCARD := $(subst %,*,$(COPY_FILE_TYPES))

COPY_FILES :=
COPY_FILES += $(foreach d,$(COPY_DIRS),\
                          $(call rwildcards,$d/,$(COPY_FILE_TYPES_WILDCARD)))

NPM_SCRIPTS =

SERVER_IP := 127.0.0.1
SERVER_PORT := 57005

WATCH_FILES += '$(APP_DIR)/**/*'
