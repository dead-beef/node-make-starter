BUILD_FILES_MIN := $(BUILD_FILES:$(BUILD_DIR)%=$(MIN_DIR)%)
DIST_FILES := $(BUILD_FILES:$(BUILD_DIR)%=$(DIST_DIR)%)

APP_OUT_DIRS += $(BUILD_DIR) $(DIST_DIR) $(MIN_DIR)
APP_OUT_DIRS := $(call uniq,$(APP_OUT_DIRS))

TARGETS += all min watch min-watch start stop \
           rebuild rebuild-min rebuild-all rebuild-all-min \
           clean clean-build install

.DEFAULT_GOAL := all

$(MODULE_DIRS):
	$(call prefix,install,$(RESET_MAKE) install)

$(APP_OUT_DIRS):
	$(call prefix,mkdirs,$(MKDIR) $@)

$(NPM_SCRIPTS):
	$(call prefix,npm,npm run $(subst -,:,$@) --silent)

all: $(BUILD_FILES)
min: $(BUILD_FILES_MIN)

rebuild: clean-build
	$(RESET_MAKE)

rebuild-min: clean-build
	$(RESET_MAKE) min

rebuild-all: clean
	$(RESET_MAKE)

rebuild-all-min: clean
	$(RESET_MAKE) min

clean: clean-build
	$(call prefix,clean,$(RM) $(DIST_DIR)/*)

clean-build:
	$(call prefix,clean,$(RM) $(BUILD_DIR)/*)

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
