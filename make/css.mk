APP_OUT_CSS_DIR := $(DIST_DIR)/css
APP_CSS =
VARS += CSS_TYPE CSS_FILES CSS_DIRS APP_CSS APP_MIN_CSS

CSS_FILES += $(foreach d,$(CSS_DIRS),$(call rwildcards,$d/,*.css))

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

$(APP_CSS): $(CSS_FILES) | $(BUILD_DIR)
	$(call prefix,css-cat,$(CAT) $^ >$@.tmp)
	$(call prefix,css-cat,$(MV) $@.tmp $@)
endif
