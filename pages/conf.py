project = "fpm"
author = f"{project} contributors"
copyright = "2021 Fortran programming language community"

extensions = [
    "ablog",
    "myst_parser",
    "sphinx_design",
    "sphinx_copybutton",
    "sphinx.ext.intersphinx",
]
myst_enable_extensions = [
    "colon_fence",
    "deflist",
    "substitution",
    "html_image",
]

html_theme = "sphinx_book_theme"
html_title = "Fortran package manager"
html_logo = "_static/fortran-logo.svg"
html_favicon = "_static/fortran-logo.svg"
locale_dirs = ["../locale/"]

_extra_navbar = """
<div class="sd-fs-6">
<a  href="../en" target="_blank">en</a>
·
<a  href="../de" target="_blank">de</a>
·
<a  href="../cn" target="_blank">cn</a>
</div>
<div class="sd-fs-4">
<a  href="https://fortran-lang.discourse.group/" target="_blank">
    <i class="fab fa-discourse"></i>
</a>
<a href="https://twitter.com/fortranlang" target="_blank">
    <i class="fab fa-twitter"></i>
</a>
<a  href="https://github.com/fortran-lang/fpm" target="_blank">
    <i class="fab fa-github"></i>
</a>
</div>
"""

html_theme_options = {
    "repository_url": "https://github.com/awvwgk/fpm-docs",
    "repository_branch": "main",
    "use_repository_button": True,
    "use_edit_page_button": True,
    "use_download_button": False,
    "path_to_docs": "pages",
    "extra_navbar": _extra_navbar,
}

html_sidebars = {
    "news": ["sidebar-logo.html", "search-field.html", "sbt-sidebar-nav.html", "tagcloud.html", "archives.html"],
    "news/**": ["sidebar-logo.html", "postcard.html", "recentposts.html", "archives.html"],
}

html_css_files = [
    "css/custom.css",
]
html_static_path = ["_static"]
templates_path = ["_templates"]

blog_path = "news"
blog_post_pattern = "news/*/*"

master_doc = "index"
