$(call load-modules,scss minify)

LINT_ENABLED := 1

APP_NAME := app
VENDOR_NAME := vendor
APP_DIR := src
CONFIG_DIR := config

JS_DIRS := $(APP_DIR)/js
JS_FILES := $(foreach d,$(JS_DIRS),$(call rwildcard,$d/,*.js))
JS_FILES := $(APP_DIR)/umd/umd-start.js $(JS_FILES) $(APP_DIR)/umd/umd-end.js

FONT_TYPES := *.otf *.eot *.svg *.ttf *.woff *.woff2
COPY_TYPES = *.jpg *.jpe *.jpeg *.png *.gif *.svg *.ico *.html

MAKEFILES += $(lastword $(MAKEFILE_LIST))

WATCH_FILES := '$(APP_DIR)/**/*' '$(CONFIG_DIR)/**/*' package.json Makefile
WATCH = chokidar $(WATCH_FILES) -i '**/.*' -c

SERVER_IP := 127.0.0.1
SERVER_PORT := 57005

SERVER_START = http-server -a $(SERVER_IP) -p $(SERVER_PORT) -c-1 $(DIST_DIR)
SERVER_STOP = -pkill -f http-server

LINT_JS = eslint $(1)

TEST_TARGETS := test test-watch test-e2e

$(call build,$(JS_FILES),$(DIST_DIR)/js/$(APP_NAME).js, , ,LINT_JS)
$(call build,$(VENDOR_JS_FILES),$(DIST_DIR)/js/$(VENDOR_NAME).js)

$(call build-scss,$(APP_DIR)/css/$(APP_NAME).scss,$(DIST_DIR)/css)
$(call build-scss,$(APP_DIR)/css/$(VENDOR_NAME).scss,$(DIST_DIR)/css)

$(call copy-wildcards,$(COPY_TYPES),$(APP_DIR),$(DIST_DIR))

$(call copy-wildcards,$(FONT_TYPES),\
                      $(RESOLVE_MATERIAL_DESIGN_ICONS_ICONFONT)/dist/fonts,\
                      $(DIST_DIR)/fonts/material-icons)

$(call copy-wildcards,$(FONT_TYPES),\
                      $(RESOLVE_MATERIALIZE_CSS)/dist/fonts/roboto,\
                      $(DIST_DIR)/fonts/roboto)

TARGETS += start stop watch min-watch

start: stop
	$(call prefix,server,$(SERVER_START))

stop:
	$(call prefix,server,$(SERVER_STOP))

watch:
	$(call prefix,build,-$(RESET_MAKE))
	$(call prefix,watch,$(WATCH) '$(RESET_MAKE)')

min-watch:
	$(call prefix,build,-$(RESET_MAKE) min)
	$(call prefix,watch,$(WATCH) '$(RESET_MAKE) min')

test:
	$(call prefix,test,karma start config/karma.conf.js --single-run)

test-watch:
	$(call prefix,test,karma start config/karma.conf.js)

test-e2e:
	$(call prefix,test,./e2e-test)
