BUILD_FILES_MIN := $(BUILD_FILES:$(BUILD_DIR)%=$(MIN_DIR)%)
DIST_FILES := $(BUILD_FILES:$(BUILD_DIR)%=$(DIST_DIR)%)

APP_OUT_DIRS += $(BUILD_DIR) $(DIST_DIR) $(MIN_DIR)
APP_OUT_DIRS := $(call uniq,$(APP_OUT_DIRS))

TARGETS += all min watch min-watch start stop rebuild clean install

.DEFAULT_GOAL := all

$(MODULE_DIRS):
	$(call prefix,install,$(RESET_MAKE) install)

$(APP_OUT_DIRS):
	$(call prefix,mkdirs,$(MKDIR) $@)

$(NPM_SCRIPTS):
	$(call prefix,npm,npm run $(subst -,:,$@) --silent)

all: $(BUILD_FILES)
min: $(BUILD_FILES_MIN)

rebuild: clean
	$(RESET_MAKE)

rebuild-min: clean
	$(RESET_MAKE) min

clean:
	$(call prefix,clean,$(RM) $(BUILD_DIR)/* $(DIST_DIR)/*)

watch:
	$(call prefix,build,-$(RESET_MAKE))
	$(call prefix,watch,$(WATCH) '$(RESET_MAKE)')

min-watch:
	$(call prefix,build,-$(RESET_MAKE) min)
	$(call prefix,watch,$(WATCH) '$(RESET_MAKE) min')

install:
	$(call prefix,install,npm install)
	$(call prefix,install,$(RESET_MAKE) $(VARS_FILE))

start: stop
	$(call prefix,start,$(START))

stop:
	$(call prefix,stop,-$(STOP))
