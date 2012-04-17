
DEFAULT_SUBDIRS = $(filter $(foreach d,$(shell find . -maxdepth 1 -type d),$(notdir $(d))),\
										src doc test)

SUBDIRS ?= $(filter $(patsubst ./%/,%,$(dir $(shell find . -maxdepth 2 -name Makefile))),$(DEFAULT_SUBDIRS))

ARCO_MK ?= /usr/share/arco

include $(ARCO_MK)/subdirs.mk
include $(ARCO_MK)/project.mk

distclean:: clean
	$(RM) -r lib bin include
