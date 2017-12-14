CONFIG_FILE := config/app.mk
MAKEFILE_DIR := make

include $(MAKEFILE_DIR)/init.mk
include $(CONFIG_FILE)

LOAD_MODULES += copy test minify main info

$(call load-modules,$(LOAD_MODULES))
