
#-- netpbm ----------------------------------------------------

%.jpg: %.png
	pngtopnm $< | pnmtojpeg > $@

#-- dia	 ----------------------------------------------------

%.eps: %.dia
	dia -n -e $@ -t eps $<

%.png: %.dia
	dia -n -e $@ -t png $<


#-- inkscape -----------------------------------------------

PNGPPP?=150
DPI?=$(PNGPPP)
# If you want other quality put next in your Makefile:
#
# include figures.mk
# DPI = <your quality>

%.pdf: %.dia
	inkscape -A $@ --export-text-to-path $<

%.png: %.svg
	inkscape -d $(DPI) -e $@ $<

%.300.png: %.svg
	inkscape -d 300 -e $@ $<

%.pdf: %.svg
	inkscape -A  $@ --export-text-to-path $<

#-- libreoffice -----------------------------------------------

%.jpg: %.ods
	unoconv -f html $<
	mv $*_html_*.jpg $@
	rm $*.html

%.pdf: %.odg
	unoconv $<

#-- gimp -------------------------------------------------------

%.png: %.xcf
	convert $< $@
