import json
import requests
from pathlib import Path

root = Path(__file__).parent.parent

data_files = {
    "registry": (
        Path(root / "_data" / "registry.json"),
        "https://raw.githubusercontent.com/fortran-lang/fpm-registry/HEAD/index.json",
    ),
}

for data_file in data_files.values():
    target, source = data_file
    if target.exists():
        continue

    if not target.parent.exists():
        target.parent.mkdir(parents=True)
    data = requests.get(source).text
    with open(target, "w", encoding="utf-8") as fd:
        fd.write(data)

project = "fpm"
author = f"{project} contributors"
copyright = "2021 Fortran programming language community"

extensions = [
    "ablog",
    "myst_parser",
    "sphinx_design",
    "sphinx_copybutton",
    "sphinx_jinja",
    "sphinx.ext.intersphinx",
]
myst_enable_extensions = [
    "colon_fence",
    "deflist",
    "substitution",
    "html_image",
]
myst_heading_anchors = 5

html_theme = "sphinx_book_theme"
html_title = "Fortran Package Manager"
html_logo = "_static/fpm-logo-color.svg"
html_favicon = "_static/fpm-logo-mono.svg"
locale_dirs = ["../locale/"]

_extra_navbar = """
<div class="sd-fs-4">
<a href="https://fortran-lang.discourse.group/" target="_blank">
    <i class="fab fa-discourse"></i>
</a>
<a href="https://twitter.com/fortranlang" target="_blank">
    <i class="fab fa-twitter"></i>
</a>
<a href="https://github.com/fortran-lang/fpm" target="_blank">
    <i class="fab fa-github"></i>
</a>
</div>
"""

html_theme_options = {
    "repository_url": "https://github.com/fortran-lang/fpm-docs",
    "repository_branch": "main",
    "use_repository_button": True,
    "use_edit_page_button": True,
    "use_download_button": False,
    "path_to_docs": "pages",
    "extra_navbar": _extra_navbar,
}

html_sidebars = {
    "news": [
        "sidebar-logo.html",
        "search-field.html",
        "sbt-sidebar-nav.html",
        "tagcloud.html",
        "archives.html",
    ],
    "news/**": [
        "sidebar-logo.html",
        "postcard.html",
        "recentposts.html",
        "archives.html",
    ],
}

html_css_files = [
    "css/custom.css",
]
html_static_path = ["_static"]
templates_path = ["_templates"]

blog_path = "news"
blog_post_pattern = "news/*/*"

copybutton_prompt_text = "❯ "

master_doc = "index"
gettext_compact = "index"

jinja_contexts = {}
for name, data_file in data_files.items():
    with open(data_file[0], "r", encoding="utf-8") as fd:
        jinja_contexts[name] = json.load(fd)

jinja_filters = {
    "is_list": lambda value: isinstance(value, list),
    "len": lambda value: len(value),
    "sort": lambda sortable: {
        key: sortable[key] for key in sorted(sortable, key=lambda value: value.lower())
    },
    "clean_repo": (
        lambda value, depth=0, sep="/": sep.join(value.split(sep)[depth:])
    ),
}
