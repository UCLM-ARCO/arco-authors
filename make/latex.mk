TOOLDIR=/usr/share/arco
FIGDIR ?= figures

MAIN ?= $(shell grep -l "^[[:space:]]*\\\\begin{document}" *.tex | sort -V)
TEX_MAIN ?= $(MAIN)
BASE = $(basename $(MAIN))
PDF = $(TEX_MAIN:.tex=.pdf)
TEX_SOURCES ?= $(shell $(TOOLDIR)/latex-parts.sh $(TEX_MAIN))

TEX_FIGURES = $(foreach file, $(TEX_SOURCES), \
                  $(shell FIGDIR=$(FIGDIR) $(TOOLDIR)/latex-figures.sh $(file)))

export LATEX_ENGINE ?= pdflatex

TEX_OUT_EXTS = aux,log,maf,mtc,lol,lot,lof,out,toc,blg,bbl,idx

define GEN_INTERMEDIATES
$(foreach tex, \
    $1, \
    $(addprefix $(basename $(notdir $(tex))), $2))
endef

# .DELETE_ON_ERROR:

all:: $(PDF)

$(PDF): $(TEX_SOURCES) $(TEX_FIGURES)

%.pdf: SHELL=/bin/bash
%.pdf: %.tex
	@echo "-- compiling '$<'"
	@$(TOOLDIR)/latex-compile.sh $<

	$(eval INTERMEDIATES := $(call GEN_INTERMEDIATES, $<, .{$(TEX_OUT_EXTS)}))
	@if [ "X$$DIRTY" = "X" ]; then \
	    $(RM) $(INTERMEDIATES); \
	fi

%.html: %.tex
	latex2html -split 0 -html_version 4.0,latin1,unicode $<

help:
	@echo "- This tries to compile all .tex files including a \\\begin{document} statement"
	@echo "  You may set a specific file: 'MAIN = your_master.tex' in your Makefile"
	@echo "- Put your figure sources in the subdirectory './figures'"
	@echo "- 'vclean' target will remove automatically converted images"
	@echo "- If you want keep intermediate files (log, aux, etc.) define DIRTY env variable"
	@echo

clean:: SHELL=/bin/bash
clean::
	@echo "-- cleanning"
	$(RM) $(call GEN_INTERMEDIATES, $(TEX_MAIN), .pdf)
	$(RM) $(call GEN_INTERMEDIATES, $(TEX_MAIN), .{$(TEX_OUT_EXTS)})

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
