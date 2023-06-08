# Minimal makefile for Sphinx documentation

# You can set these variables from the command line.
LANGUAGES     ?= cs de zh_CN es fr nl ja pt ru
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SPHINXINTL    ?= sphinx-intl
SOURCEDIR     ?= pages
BUILDDIR      ?= _build
LOCALEDIR     ?= locale
BASE_LANG     ?= en

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help $(MAKEFILES)

html: $(addprefix html/,$(LANGUAGES)) $(addprefix html/,$(BASE_LANG))
	@echo "Pages available at file://$$PWD/$(BUILDDIR)/html/index.html"

$(addprefix html/,$(LANGUAGES)): $(MAKEFILES)
	@$(SPHINXBUILD) "$(SOURCEDIR)" "$(BUILDDIR)/$@" $(SPHINXOPTS) -Dlanguage=$(word 2,$(subst /, ,$@))

$(addprefix html/,$(BASE_LANG)): $(MAKEFILES)
	@$(SPHINXBUILD) "$(SOURCEDIR)" "$(BUILDDIR)/html/" $(SPHINXOPTS) -Dlanguage=$(word 2,$(subst /, ,$@))

gettext: $(MAKEFILES)
	@$(SPHINXBUILD) -b $@ "$(SOURCEDIR)" "$(BUILDDIR)/$@" $(SPHINXOPTS)
	@$(SPHINXINTL) update -w 80 -p "$(BUILDDIR)/$@" -d locale $(addprefix -l,$(filter-out en,$(LANGUAGES)))
