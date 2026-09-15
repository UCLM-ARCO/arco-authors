# -*- mode:makefile -*-
# ----------------------------------------------------------------------
# Required pkgs: libreoffice
# Optional vars: SOFFICE
# ----------------------------------------------------------------------
# usage: $(call soffice-convert,<format>,<expected output file>)
#
# Concurrent soffice processes sharing the same profile (make -j) fail
# silently: some exit with 1 and no message, so check the output file.

SOFFICE ?= soffice --headless

define soffice-convert
	$(RM) $(2)
	$(SOFFICE) --convert-to $(1) --outdir $(@D) $< && test -s $(2) || { \
	  echo "ERROR: soffice did not generate '$(2)' from '$<'." >&2; \
	  echo "soffice can not run in parallel: do not use 'make -j'" >&2; \
	  echo "and close other LibreOffice instances." >&2; \
	  exit 1; }
endef
