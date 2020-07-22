include ${shell get-project-dir}/make/latex.mk

IMAGE_URL=https://bitbucket.org/arco_group/logos/raw/989e45beafdff774a36b0860311218435cf80ee7/esi.svg

figures/esi.svg:
	curl -# $(IMAGE_URL) -o $@

vclean::
	$(RM) figures/esi.svg
