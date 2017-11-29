VARS_FILE := $(BUILD_DIR)/vars.mk
MAKEFILES += $(VARS_FILE)
-include $(VARS_FILE)

ifneq "$(MAKECMDGOALS)" "install"
$(VARS_FILE): package.json make/make-vars.js config/override.js | $(BUILD_DIR) $(MAKE_VARS) $(MODULE_DIRS)
	$(call prefix,vars,$(MAKE_VARS_CMD) >$@.tmp)
	$(call prefix,vars,$(MV) $@.tmp $@)
endif
