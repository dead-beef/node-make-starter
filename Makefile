OVERRIDE_CONFIG_FILE := config/override.js
include make/Makefile

LINT_ENABLED := 1

APP_NAME := app
VENDOR_NAME := vendor
APP_DIR := src
CONFIG_DIR := config

FONT_TYPES := *.otf *.eot *.svg *.ttf *.woff *.woff2
COPY_TYPES = *.jpg *.jpe *.jpeg *.png *.gif *.svg *.ico *.html

JS_FILES := $(APP_DIR)/umd/umd-start.js \
            $(call rwildcard,$(APP_DIR)/js/,*.js) \
            $(APP_DIR)/umd/umd-end.js

WATCH_FILES := '$(APP_DIR)/**/*' '$(CONFIG_DIR)/**/*' package.json Makefile

MAKEFILES += $(lastword $(MAKEFILE_LIST))

TARGETS += start stop watch min-watch
TEST_TARGETS := test test-watch test-e2e

$(call build-and-minify,\
    $(JS_FILES),\
    $(BUILD_DIR)/js/$(APP_NAME).js,\
    $(MIN_DIR)/js/$(APP_NAME).js,\
    SOURCE_MAP_CONCAT,SOURCE_MAP_UGLIFY,ESLINT)

$(call build-and-minify,\
    $(VENDOR_JS_FILES),\
    $(BUILD_DIR)/js/$(VENDOR_NAME).js,\
    $(MIN_DIR)/js/$(VENDOR_NAME).js,\
    SOURCE_MAP_CONCAT,SOURCE_MAP_UGLIFY)

$(call build-and-minify,\
    $(APP_DIR)/css/$(APP_NAME).scss,\
    $(BUILD_DIR)/css/$(APP_NAME).css,\
    $(MIN_DIR)/css/$(APP_NAME).css,\
    NODE_SASS,CSSO, ,SASS_MAKEDEPEND)

$(call build-and-minify,\
    $(APP_DIR)/css/$(VENDOR_NAME).scss,\
    $(BUILD_DIR)/css/$(VENDOR_NAME).css,\
    $(MIN_DIR)/css/$(VENDOR_NAME).css,\
    NODE_SASS,CSSO, ,SASS_MAKEDEPEND)

$(call copy-wildcards,$(COPY_TYPES),$(APP_DIR),$(DIST_DIR))

$(call copy-wildcards,$(FONT_TYPES),\
                      $(RESOLVE_MATERIAL_DESIGN_ICONS_ICONFONT)/dist/fonts,\
                      $(DIST_DIR)/fonts/material-icons)

$(call copy-wildcards,$(FONT_TYPES),\
                      $(RESOLVE_MATERIALIZE_CSS)/dist/fonts/roboto,\
                      $(DIST_DIR)/fonts/roboto)

$(call main)

all min: | $(DIST_DIR)/$(APP_DIR)

all:
	$(call prefix,link,$(LN) ../$(BUILD_DIR)/js $(DIST_DIR)/js)
	$(call prefix,link,$(LN) ../$(BUILD_DIR)/css $(DIST_DIR)/css)

min:
	$(call prefix,link,$(LN) ../$(MIN_DIR)/js $(DIST_DIR)/js)
	$(call prefix,link,$(LN) ../$(MIN_DIR)/css $(DIST_DIR)/css)

$(DIST_DIR)/$(APP_DIR): | $(DIST_DIR)
	$(call prefix,mkdir,$(LN) ../$(APP_DIR) $@)

start: stop
	$(call prefix,server,$(SERVER_START))

stop:
	$(call prefix,server,$(SERVER_STOP))

watch:
	$(call prefix,build,-$(RESET_MAKE))
	$(call prefix,watch,$(call WATCH,$(WATCH_FILES),'$(RESET_MAKE)'))

min-watch:
	$(call prefix,build,-$(RESET_MAKE) min)
	$(call prefix,watch,$(call WATCH,$(WATCH_FILES),'$(RESET_MAKE) min'))

#pre-test: all

test:
	$(call prefix,test,karma start config/karma.conf.js --single-run)

test-watch:
	$(call prefix,test,karma start config/karma.conf.js)

test-e2e:
	$(call prefix,test,./e2e-test)
