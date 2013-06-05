TOOLDIR=/usr/share/arco
FIGDIR ?= figures

RUBBER_WARN ?= refs
RUBBER=rubber $(RUBBER_FLAGS) --texpath ~/.texmf -m hyperref --warn $(RUBBER_WARN)

MAIN ?= $(shell grep -l "^[[:space:]]*\\\\begin{document}" *.tex)
TEX_MAIN ?= $(MAIN)
PDF = $(TEX_MAIN:.tex=.pdf)
TEX_SOURCES ?= $(shell $(TOOLDIR)/latex-parts.sh $(TEX_MAIN))

TEX_FIGURES = $(addprefix $(FIGDIR)/, \
	        $(foreach file, $(TEX_SOURCES), \
                  $(shell $(TOOLDIR)/latex-figures.sh $(file))))

all:: $(PDF)

$(PDF): $(TEX_SOURCES) $(TEX_FIGURES)

%.pdf: %.tex
	$(RUBBER) --pdf $<
	-@ ! grep --color Reference $(<:.tex=.log)
	-@ ! grep --color Citation $(<:.tex=.log)
	-@ ! grep --color "multiply defined" $(<:.tex=.log)
	-@ ! grep "acronym Warning" $(<:.tex=.log) | sort | uniq | grep --color "acronym Warning"
	-@ ! rgrep --color FIXME *.tex


%.html: %.tex
	latex2html -split 0 -html_version 4.0,latin1,unicode $<

help:
	@echo "- This ties to compile all .tex files including a \begin{document} statement"
	@echo "  You may set a specific file: 'MAIN = your_master.tex' in your Makefile"
	@echo "- Put your figure sources in the subdirectory './figures'."
	@echo "- 'vclean' target will remove automatically converted images."
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
