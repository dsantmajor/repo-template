
WORKING_DIR := $(shell pwd)

.DEFAULT_GOAL := help

export ENV_PATH ?= local
export CONFIG ?= local
export CONFIG_ENV ?= env/$(ENV_PATH)/$(CONFIG).env

ENVY_MK := .envy.mk
$(eval $(shell ./vendor_utils/envy.sh/envy.sh "$(CONFIG_ENV)" make "$(ENVY_MK)" && echo "include $(ENVY_MK)" || echo "\$$(error Problem running envy)"))



.PHONY: clean
clean: ## Delete the values in .envy.mk
	-rm -f $(ENVY_MK)

# A help target including self-documenting targets (see the awk statement)
define HELP_TEXT
Usage: make [TARGET]... [MAKEVAR1=SOMETHING]...

Available targets:
endef
export HELP_TEXT
help: ## This help target
	@cat .banner
	@echo " "
	@echo " "
	@echo "Clone this repo as a template"
	@echo " "
	@echo " "
	@echo "$$HELP_TEXT"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
		{printf "\033[36m%-30s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)

