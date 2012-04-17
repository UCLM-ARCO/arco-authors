
SHELL=/bin/bash
PROJECT_DIR = $(shell \
	function get_root_dir() { \
		test -f $$1/project.mk && echo $$1 && return 0; \
		[ "$$1" == "/" ] && return 1; \
		get_root_dir "$$(dirname $$1)"; \
	}; \
	get_root_dir $$(pwd))

-include /home/$(USER)/userproject.mk
include $(PROJECT_DIR)/project.mk

DESTDIR ?= /home/$(USER)
