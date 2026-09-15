# -*- mode:makefile -*-
# ----------------------------------------------------------------------
# Required pkgs: libreoffice-writer
# Optional vars: ODT
# ----------------------------------------------------------------------

include arco/pdfjam.mk
include arco/soffice.mk

ODT ?= $(wildcard *.odt)

all::  $(PDF)

%.pdf: %.odt
	$(call soffice-convert,pdf,$@)

clean::
	$(RM) temp *~ $(PDF)
