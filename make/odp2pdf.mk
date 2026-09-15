# -*- mode:makefile -*-
# ----------------------------------------------------------------------
# Required pkgs: libreoffice-impress
# Optional vars: ODP ODP-IGNORE
# ----------------------------------------------------------------------

include arco/pdfjam.mk
include arco/soffice.mk

ODP ?= $(filter-out $(ODP-IGNORE), $(wildcard *.odp))

PDF1 = $(patsubst %.odp,%.pdf, $(ODP))
PDF3 = $(patsubst %.odp,%.1x3.pdf, $(ODP))
PDFM = $(patsubst %.odp,%.2x4.pdf, $(ODP))

PDF=$(PDF1) $(PDF3) $(PDFM)

all::  $(PDF)

%.pdf: %.odp
	$(call soffice-convert,pdf,$@)

clean::
	$(RM) temp *~ $(PDF)
