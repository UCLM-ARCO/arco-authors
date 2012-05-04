# -*- mode:makefile -*-
# ----------------------------------------------------------------------
# Required pkgs: unovonv, pdfjam, pdftk
# Optional vars: ODP ODP-IGNORE
# ----------------------------------------------------------------------

.INTERMEDIATE: *.first.pdf *.2x2.pdf

TMP = /tmp/odp2pdf

ODP ?= $(filter-out $(ODP-IGNORE), $(wildcard *.odp))

PDF1 = $(patsubst %.odp,%.pdf, $(ODP))
PDF3 = $(patsubst %.odp,%.1x3.pdf, $(ODP))
PDFM = $(patsubst %.odp,%.2x4.pdf, $(ODP))

PDF=$(PDF1) $(PDF3) $(PDFM)

PDFNUP=pdfnup --quiet --paper a4paper
DELTA08=--delta  "0.8cm 0.8cm"

all:  $(PDF)

%.pdf: %.odp
	odp2pdf $<

%.1x3.pdf: %.pdf
	$(PDFNUP) $(DELTA08) --no-landscape --scale 0.9 --frame true --offset "-3cm 0" --nup 1x3 $< --outfile $@

%.first.pdf: %.pdf
	$(PDFNUP) $(DELTA08) --frame true --nup 1x1 $< 1 --outfile $@

%.2x2.pdf: %.pdf
	$(PDFNUP) $(DELTA08) --frame true --nup 2x2 $< 2- --outfile $@

%.2x4.pdf: %.pre2x4.pdf
	$(PDFNUP) --no-landscape --nup 1x2 --scale 0.9 --delta "0.45cm 0.45cm" $< --outfile $@

%.pre2x4.pdf: %.first.pdf %.2x2.pdf
	pdfjoin --quiet $^ --outfile $@

clean:
	$(RM) temp *~ $(PDF)
