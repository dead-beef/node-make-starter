APP_OUT_CSS_DIR := $(DIST_DIR)/css
APP_CSS =
VARS += CSS_TYPE CSS_FILES CSS_DIRS CSS_DEPS \
        CSS_INCLUDE_PATH APP_CSS APP_MIN_CSS

ifneq "$(findstring .scss,$(CSS_FILES))" ""
CSS_DEPS := $(CSS_FILES) $(foreach d,$(CSS_DIRS),\
                                   $(call rwildcards,$d/,*.css *.scss))
CSS_DEPS := $(filter-out $(LIB_CSS_FILES) $(LIB_CSS_DEPS),$(CSS_DEPS))
CSS_INCLUDE_PATH := $(call join-with,:,$(CSS_DIRS) $(MODULE_DIRS))

CSS_TYPE := scss
else
CSS_FILES += $(foreach d,$(CSS_DIRS),$(call rwildcards,$d/,*.css))
CSS_TYPE := css
endif

ifneq "$(strip $(CSS_FILES))" ""
APP_CSS := $(BUILD_DIR)/$(APP_NAME).css
APP_MIN_CSS := $(APP_CSS:$(BUILD_DIR)%=$(MIN_DIR)%)
APP_OUT_DIR += $(APP_OUT_CSS_DIR)
BUILD_FILES += $(APP_CSS)

TARGETS += copy-app-css copy-app-min-css

all: copy-app-css
min: copy-app-min-css

copy-app-css: $(APP_CSS) | $(APP_OUT_CSS_DIR)
	$(call prefix,dist,$(CPDIST) $(APP_CSS) $(APP_OUT_CSS_DIR))

copy-app-min-css: $(APP_MIN_CSS) | $(APP_OUT_CSS_DIR)
	$(call prefix,dist,$(CPDIST) $(APP_MIN_CSS) $(APP_OUT_CSS_DIR))

ifeq "$(CSS_TYPE)" "scss"
$(APP_CSS): $(CSS_DEPS) | $(BUILD_DIR)
	$(call prefix,sass,$(CAT) $(CSS_FILES) | $(SASS) >$@.tmp)
	$(call prefix,sass,$(MV) $@.tmp $@)
else ifeq "$(CSS_TYPE)" "css"
$(APP_CSS): $(CSS_FILES) | $(BUILD_DIR)
	$(call prefix,css-cat,$(CAT) $^ >$@.tmp)
	$(call prefix,css-cat,$(MV) $@.tmp $@)
else
$(error Unknown css type: $(CSS_TYPE))
endif

endif
