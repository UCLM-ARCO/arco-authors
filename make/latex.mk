TOOLDIR=/usr/share/arco
FIGDIR ?= figures

# RUBBER_WARN ?= refs
# RUBBER_ARGS=--texpath ~/.texmf --module hyperref --warn $(RUBBER_WARN) $(RUBBER_FLAGS)

MAIN ?= $(shell grep -l "^[[:space:]]*\\\\begin{document}" *.tex)
TEX_MAIN ?= $(MAIN)
BASE = $(basename $(MAIN))
PDF = $(TEX_MAIN:.tex=.pdf)
TEX_SOURCES ?= $(shell $(TOOLDIR)/latex-parts.sh $(TEX_MAIN))

TEX_FIGURES = $(foreach file, $(TEX_SOURCES), \
                  $(shell FIGDIR=$(FIGDIR) $(TOOLDIR)/latex-figures.sh $(file)))

export LATEX_ENGINE  ?= pdflatex

# .DELETE_ON_ERROR:

all:: $(PDF)

$(PDF): $(TEX_SOURCES) $(TEX_FIGURES)

%.pdf: %.tex
	@echo "-- compiling '$<'"
	@$(TOOLDIR)/latex-compile.sh $<

%.html: %.tex
	latex2html -split 0 -html_version 4.0,latin1,unicode $<

help:
	@echo "- This ties to compile all .tex files including a \begin{document} statement"
	@echo "  You may set a specific file: 'MAIN = your_master.tex' in your Makefile"
	@echo "- Put your figure sources in the subdirectory './figures'."
	@echo "- 'vclean' target will remove automatically converted images."
	@echo

clean::
	@echo "-- cleanning"
	$(RM) $(foreach tex, \
		$(TEX_MAIN), \
	        $(addprefix $(basename $(notdir $(tex))), \
		    .pdf .aux .log .maf .mtc .lol .lot .lof .out .toc .blg .bbl))
	$(RM) *~


vclean:: clean
	$(RM) $(strip $(foreach figure, \
		$(TEX_FIGURES), \
		$(shell test "1" != `ls $(basename $(figure)).* | wc -l` && echo $(figure))))

include arco/figures.mk


## Local Variables:
##  coding: utf-8
##  mode: makefile
## End:
