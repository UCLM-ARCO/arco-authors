include ${shell get-project-dir}/make/latex.mk

figures/esi.svg:
	curl -# https://bytebucket.org/arco_group/logos/raw/tip/informatica.svg  -o $@

vclean::
	$(RM) figures/esi.svg
