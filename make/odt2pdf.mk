# -*- mode:makefile -*-
# ----------------------------------------------------------------------
# Required pkgs: unovonv
# Optional vars: ODT
# ----------------------------------------------------------------------

include arco/pdfjam.mk

ODT ?= $(wildcard *.odt)

all::  $(PDF)

%.pdf: %.odt
	odt2pdf $<

clean::
	$(RM) temp *~ $(PDF)
