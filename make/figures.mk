#-- netpbm ----------------------------------------------------

%.jpg: %.png
	pngtopnm $< | pnmtojpeg > $@

#-- dia	 ----------------------------------------------------

%.eps: %.dia
	dia --nosplash --export $@ --filter eps $<

%.png: %.dia
	dia --nosplash --export $@ --filter png $<


#-- inkscape -----------------------------------------------

DISPLAY=
PNGPPP?=150
DPI?=$(PNGPPP)
# If you want other quality put next in your Makefile:
#
# include figures.mk
# DPI = <your quality>

%.png: %.svg
	arco-svg2png $< $@ $(DPI)

%.300.png: %.svg
	arco-svg2png $< $@ 300

%.pdf: %.dia
	arco-svg2pdf $< $@

%.pdf: %.svg
	arco-svg2pdf $< $@

#-- blockdiag

%.svg: %.packetdiag
	packetdiag $< -T svg

%.svg: %.blockdiag
	blockdiag $< -T svg


#-- graphviz --------------------------------------------------

DOTENGINE?=fdp

%.png: %.dot
	dot $< -o $@ -T png -K $(DOTENGINE)

%.pdf: %.dot
	dot $< -o $@ -T pdf -K $(DOTENGINE)

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
