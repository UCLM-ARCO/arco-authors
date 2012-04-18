#!/usr/bin/make -f
# -*- coding:utf-8 -*-

DESTDIR?=~

FINAL=/usr/share/arco
BASE=$(DESTDIR)$(FINAL)
MK=$(DESTDIR)/usr/include/arco
LATEXSITE=$(DESTDIR)/usr/share/texmf/tex/latex/arco
BIBDIR=$(DESTDIR)/usr/share/texmf/bibtex/bst/es-bib
FIGURES=$(DESTDIR)/$(FINAL)/figures
DOCDIR=$(DESTDIR)/usr/share/doc

LOGOS=http://arco.esi.uclm.es/svn/public/doc/logos
WGET=wget --no-check-certificate -nv

all:
	sed s/CLASS/book/g tex/arco.cls.in > tex/arco-book.cls
	sed s/CLASS/report/g tex/arco.cls.in > tex/arco-report.cls

clean:
	$(RM) $(shell find -name *~)
	find . -name "*.elc" -delete
	$(RM) compile.el tex/arco-book.cls tex/arco-report.cls
#	$(MAKE) -C samples clean

install:
	install -vd $(BASE)
	install -v -m 555 tex/*.sh  $(BASE)/
	install -v -m 555 docbook/*.sh $(BASE)/
	install -v -m 444 bash/*.sh  $(BASE)/

	install -vd $(MK)/bin
	install -v -m 444 make/*.mk $(MK)/
	install -v -m 444 make/bin/* $(MK)/bin/

	for i in $$(ls make); do \
	    echo  "\$$(warning Deprecation warning: '$$i' is now at /usr/include/arco. See samples and update your Makefiles)\ninclude arco/$$i" > $(BASE)/$$i; \
	done

	install -vd $(LATEXSITE)
	install -v -m 444 tex/*.cls $(LATEXSITE)
	install -v -m 444 tex/*.sty $(LATEXSITE)
	install -vd $(BIBDIR)
	install -v -m 444 tex/*.bst $(BIBDIR)

	install -vd $(DESTDIR)/usr/bin
	install -v -m 755 bin/* $(DESTDIR)/usr/bin/

	install -v -m 755 bin.share/* $(BASE)/

	install -vd $(FIGURES)
	@$(WGET) $(LOGOS)/uclm.pdf            -O $(FIGURES)/uclm.pdf
	@$(WGET) $(LOGOS)/uclm_logo_bw.mp.pdf -O $(FIGURES)/uclm-logo-bw-mp.pdf
	@$(WGET) $(LOGOS)/uclm-A4.pdf         -O $(FIGURES)/uclm-A4.pdf
	@$(WGET) $(LOGOS)/arco-white.pdf      -O $(FIGURES)/arco-white.pdf
	@$(WGET) $(LOGOS)/arco-watermark.pdf  -O $(FIGURES)/arco-watermark.pdf

	install -vd $(DOCDIR)/arco-authors
	tar cvfz $(DOCDIR)/arco-authors/samples.tgz --directory samples latex docbook

	install -vd $(DOCDIR)/arco-devel
	tar cvfz $(DOCDIR)/arco-devel/sample.tgz --directory samples make
