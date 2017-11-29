TEST_TARGETS := test test-watch test-e2e test-all
TARGETS += $(TEST_TARGETS)
TEST_TARGETS += $(filter test%,$(NPM_SCRIPTS))
VARS += TEST_TARGETS

#$(TEST_TARGETS): all

ifneq "$(strip $(LIBRARY))" ""
$(TEST_TARGETS): $(LIB_JS)
endif

test:
	$(call prefix,test,$(TEST))

test-watch:
	$(call prefix,test,$(TEST_WATCH))

test-e2e:
	$(call prefix,test,$(TEST_E2E))

test-all: test test-e2e
