# -*- mode:makefile -*-
# ----------------------------------------------------------------------
# Required pkgs: unovonv
# Optional vars: ODP ODP-IGNORE
# ----------------------------------------------------------------------

include arco/pdfjam.mk

ODP ?= $(filter-out $(ODP-IGNORE), $(wildcard *.odp))

PDF1 = $(patsubst %.odp,%.pdf, $(ODP))
PDF3 = $(patsubst %.odp,%.1x3.pdf, $(ODP))
PDFM = $(patsubst %.odp,%.2x4.pdf, $(ODP))

PDF=$(PDF1) $(PDF3) $(PDFM)

all::  $(PDF)

%.pdf: %.odp
	odp2pdf $<

clean::
	$(RM) temp *~ $(PDF)
