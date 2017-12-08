MAKEFILE_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
include $(MAKEFILE_DIR)/macros.mk
$(eval $(call load-modules,commands vars))
