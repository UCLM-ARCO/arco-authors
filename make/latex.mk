TOOLDIR=/usr/share/arco
FIGDIR=figures

RUBBER_WARN ?= refs
RUBBER=rubber $(RUBBER_FLAGS) --texpath ~/.texmf -m hyperref --warn $(RUBBER_WARN)

MAIN ?= $(shell grep -l "^[[:space:]]*\\\\begin{document}" *.tex)
TEX_MAIN ?= $(MAIN)
PDF = $(TEX_MAIN:.tex=.pdf)
TEX_SOURCE ?= $(shell $(TOOLDIR)/latex-parts.sh $(TEX_MAIN))

TEX_FIGURES = $(addprefix $(FIGDIR)/, \
	        $(foreach file, $(TEX_SOURCE), \
                  $(shell $(TOOLDIR)/latex-figures.sh $(file))))

all:: $(PDF)

$(PDF): $(TEX_SOURCE) $(TEX_FIGURES)

%.pdf: %.tex
	$(RUBBER) --pdf $<
	-@ ! grep Citation $(<:.tex=.log)

help:
	@echo "- The name for the master TeX file should be: 'main.tex'"
	@echo "  But you can changed defining: 'MAIN = your_master.tex' in your Makefile"
	@echo "- Put your image sources in the subdirectory 'figures'."
	@echo "- 'vclean' target remove automatically converted images."
	@echo

clean::
	-$(RUBBER) --clean --pdf $(TEX_MAIN)
	$(RM) *~ *.maf *.mtc *.lol
	$(RM) $(foreach tex, \
		$(TEX_MAIN), \
	        $(addprefix $(basename $(notdir $(tex))), .blg .bbl))

vclean:: clean
	$(RM) $(strip $(foreach figure, \
		$(TEX_FIGURES), \
		$(shell test "1" != `ls $(basename $(figure)).* | wc -l` && echo $(figure))))

include arco/figures.mk


## Local Variables:
##  coding: utf-8
##  mode: makefile
## End:
