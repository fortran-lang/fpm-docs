# Minimal makefile for Sphinx documentation

# You can set these variables from the command line.
LANGUAGES     ?= en cs de zh_CN es fr nl ja pt ru in
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SPHINXINTL    ?= sphinx-intl
SOURCEDIR     ?= pages
BUILDDIR      ?= _build
LOCALEDIR     ?= locale

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help $(MAKEFILES)

html: $(addprefix html/,$(LANGUAGES)) $(BUILDDIR)/html/index.html
	@echo "Pages available at file://$$PWD/$(BUILDDIR)/html/index.html"

$(addprefix html/,$(LANGUAGES)): $(MAKEFILES)
	@$(SPHINXBUILD) "$(SOURCEDIR)" "$(BUILDDIR)/$@" $(SPHINXOPTS) -Dlanguage=$(word 2,$(subst /, ,$@))

$(BUILDDIR)/html/index.html: html/index.html
	@cp $< $@

gettext: $(MAKEFILES)
	@$(SPHINXBUILD) -b $@ "$(SOURCEDIR)" "$(BUILDDIR)/$@" $(SPHINXOPTS)
	@$(SPHINXINTL) update -w 80 -p "$(BUILDDIR)/$@" -d locale $(addprefix -l,$(filter-out en,$(LANGUAGES)))
