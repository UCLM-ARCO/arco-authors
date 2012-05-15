# -*- mode:makefile -*-
# ----------------------------------------------------------------------
# Required pkgs: pdfjam
# ----------------------------------------------------------------------

.INTERMEDIATE: *.1.pdf *.2-.2x2.pdf *.pre2x4.pdf

PDFNUP=pdfnup --quiet --paper a4paper
DELTA08=--delta  "0.8cm 0.8cm"

%.2x1.pdf: %.pdf
	$(PDFNUP) $(DELTA08) --frame true --nup 2x1 $< --outfile $@

%.1x3.pdf: %.pdf
	$(PDFNUP) $(DELTA08) --no-landscape --scale 0.9 --frame true --offset "-3cm 0" --nup 1x3 $< --outfile $@

%.2x2.pdf: %.pdf
	$(PDFNUP) $(DELTA08) --frame true --nup 2x2 $< --outfile $@

%.1.pdf: %.pdf
	$(PDFNUP) $(DELTA08) --frame true --nup 1x1 $< 1 --outfile $@

%.2-.2x2.pdf: %.pdf
	$(PDFNUP) $(DELTA08) --frame true --nup 2x2 $< 2- --outfile $@

%.2x4.pdf: %.pre2x4.pdf
	$(PDFNUP) --no-landscape --nup 1x2 --scale 0.9 --delta "0.45cm 0.45cm" $< --outfile $@

%.pre2x4.pdf: %.1.pdf %.2-.2x2.pdf
	pdfjoin --quiet $^ --outfile $@
