#!/usr/bin/make -f
# -*- coding:utf-8 -*-

DESTDIR?=~

FINAL=/usr/share/arco
BASE=$(DESTDIR)$(FINAL)
MK=$(DESTDIR)/usr/include/arco
LATEXSITE=$(DESTDIR)/usr/share/texmf/tex/latex/arco
BIBDIR=$(DESTDIR)/usr/share/texlive/texmf-dist/bibtex/bst/es-bib
FIGURES=$(DESTDIR)/$(FINAL)/figures
DOCDIR=$(DESTDIR)/usr/share/doc

# LOGOS=http://arco.esi.uclm.es/svn/public/doc/logos
LOGOS=https://bitbucket.org/arco_group/logos/raw/tip
WGET=wget --no-check-certificate -nv

all:
	sed s/CLASS/book/g tex/arco.cls.in > tex/arco-book.cls
	sed s/CLASS/report/g tex/arco.cls.in > tex/arco-report.cls
	sed s/CLASS/article/g tex/arco.cls.in > tex/arco-article.cls
	inkscape --export-pdf figures/placeholder_entity.pdf --export-text-to-path figures/placeholder_entity.svg

clean:
	$(RM) $(shell find -name *~)
	find . -name "*.elc" -delete
	$(RM) compile.el tex/arco-book.cls tex/arco-report.cls tex/arco-article.cls

vclean: clean
	$(MAKE) -C examples clean

install:
	install -vd $(BASE)
	install -v -m 555 scripts/*  $(BASE)/

	install -vd $(MK)
	install -v -m 444 make/*.mk $(MK)/

	install -vd $(LATEXSITE)
	install -v -m 444 tex/*.cls $(LATEXSITE)
	install -v -m 444 tex/*.sty $(LATEXSITE)

	install -vd $(BIBDIR)
	install -v -m 444 tex/*.bst $(BIBDIR)

	install -vd $(DESTDIR)/usr/bin
	install -v -m 555 bin/* $(DESTDIR)/usr/bin/

	install -vd $(FIGURES)
	install -v -m 444 figures/* $(FIGURES)

	install -vd $(DOCDIR)/arco-authors
	tar cvfz $(DOCDIR)/arco-authors/examples.tgz --directory examples latex docbook

download-images:
	@$(WGET) $(LOGOS)/esi.pdf              	  -O figures/esi.pdf
	@$(WGET) $(LOGOS)/esi_logo.pdf            -O figures/esi_logo.pdf
	@$(WGET) $(LOGOS)/uclm_logo.pdf        	  -O figures/uclm_logo.pdf
	@$(WGET) $(LOGOS)/arco_white.pdf       	  -O figures/arco_entity.pdf
	@$(WGET) $(LOGOS)/arco_watermark.pdf   	  -O figures/arco_watermark.pdf
	@$(WGET) $(LOGOS)/uclm_logomarca_1.pdf 	  -O figures/uclm_logomarca_1.pdf
	@$(WGET) $(LOGOS)/uclm_logomarca_3.pdf 	  -O figures/uclm_logomarca_3.pdf
	@$(WGET) $(LOGOS)/uclm_logo_watermark.pdf -O figures/uclm_logo_watermark.pdf
	@$(WGET) $(LOGOS)/informatica_gray.pdf    -O figures/informatica_gray.pdf
