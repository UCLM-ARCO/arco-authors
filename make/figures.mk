#-- netpbm ----------------------------------------------------

%.jpg: %.png
	pngtopnm $< | pnmtojpeg > $@

#-- dia	 ----------------------------------------------------

%.eps: %.dia
	dia --nosplash --export $@ --filter eps $<

%.png: %.dia
	dia --nosplash --export $@ --filter png $<


#-- inkscape -----------------------------------------------

PNGPPP?=150
DPI?=$(PNGPPP)
# If you want other quality put next in your Makefile:
#
# include figures.mk
# DPI = <your quality>

%.png: %.svg
	inkscape --export-dpi $(DPI) --export-png $@ $<

%.300.png: %.svg
	inkscape --export-dpi 300 --export-png $@ $<

%.pdf: %.dia
	inkscape --export-pdf $@ --export-text-to-path $<

%.pdf: %.svg
	inkscape --export-pdf $@ --export-text-to-path $<

#-- libreoffice -----------------------------------------------

%.jpg: %.ods
	unoconv --format html $<
	mv $*_html_*.jpg $@
	rm $*.html

%.pdf: %.odg
	unoconv $<

%.png: %.odg
	unoconv -o $@ $<



#-- gimp -------------------------------------------------------

%.png: %.xcf
	convert $< $@
