SPACE :=
SPACE +=
LP := (
RP := )
COMMA := ,
QUOTE := "
# "
QUOTE2 := \"
# "

#--------

join-with = $(subst $(SPACE),$1,$(strip $2))

uniq = $(if $1,$(firstword $1) $(call uniq,$(filter-out $(firstword $1),$1)))

src-to-min = $(patsubst %.js,%.min.js,$(patsubst %.css,%.min.css,$1))

define rwildcard
	$(wildcard $1$2) \
	$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))
endef

define rwildcards
	$(foreach p,$2,$(wildcard $1$p)) \
	$(foreach d,$(wildcard $1*),$(call rwildcards,$d/,$2))
endef

define prefix
	@$(ECHO) "  $1 $(strip $(subst $$,\\$$,$(subst $(QUOTE),$(QUOTE2),$(2))))"
	@$(2)
endef

define link-module-dir
	$(call join-with,/,$(patsubst %,..,$(subst /,$(SPACE),$(dir $1))) \
	                   $(notdir $1))
endef
