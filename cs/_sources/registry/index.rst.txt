Registry
========

Welcome to the package registry for the Fortran package manager.
All currently registered packages can be found here.

.. note::

   Your project is not listed?
   Submit a request at `fortran-lang/fpm-registry <https://github.com/fortran-lang/fpm-registry>`_!


.. note

   This section is purposely in ReStructuredText rather than MyST-Markdown.
   Writing the following templated block with MyST will only lead to pain and suffering.


.. jinja:: registry

   .. packages come sorted chronologically, we want alphabetical order here
   {% for package, versions in (packages | sort).items() %}

   .. each package should be referenceable, this allows cross-linking of dependencies
   .. _pkg-{{ package }}:

   {{ package }}
   {{ (package | len) * "-" }}

   .. we filter out the latest version first to avoid repeating the package meta data
   {% for version, data in versions.items() if version == "latest" %}

   {% if data["git"].startswith("https://github.com/") %}
   :fab:`github`
   `{{ data["git"] | clean_repo(3) }} <{{ data["git"] }}>`__
   {% elif data["git"].startswith("https://gitlab.com/") %}
   :fab:`gitlab`
   `{{ data["git"] | clean_repo(3) }} <{{ data["git"] }}>`__
   {% elif data["git"].startswith("https://bitbucket.org/") %}
   :fab:`bitbucket`
   `{{ data["git"] | clean_repo(3) }} <{{ data["git"] }}>`__
   {% else %}
   :fab:`git-alt`
   `{{ data["git"] | clean_repo(2) }} <{{ data["git"] }}>`__
   {% endif %}

   {% if data.get("author", False) %}
   .. the author entry is not normalized and either a string or list of strings
   by {{ " and ".join(data["author"]) if data["author"] | is_list else data["author"] }}
   {% endif %}

   {% if data.get("description", False) %}
   {{ data["description"].strip() }}
   {% endif %}
   {% endfor %}

   {% for version, data in (versions | sort).items() %}
   .. card::
      :class-header: sd-font-weight-bold sd-border-0
      :class-body: sd-py-0
      :class-footer: sd-border-0

      :fa:`cubes`
      {{ "Latest version" if version == "latest" else "Version " + version }}
      ^^^
      .. provide a copyable code-block for the package manifest,
         in case of a concrete version we must specify the tag explicitly

      .. code:: toml

         [dependencies]
         {{ data["name"] }}.git = "{{ data["git"] | clean_repo }}"
         {% if data.get("git-tag", False) %}{{ data["name"] }}.tag = "{{ data["git-tag"] }}"{% endif %}

      {% if data.get("dependencies", False) %}
      .. the registry captures the direct dependencies of a package,
         we use the reference created in each header to create cross-links
      +++
      *Dependencies*

      .. grid:: 3
         :gutter: 2
         {% for dependency, url in (data["dependencies"] | sort).items() %}
         .. grid-item-card::
            :class-card: sd-outline-{{ "primary" if dependency in packages else "warning" }}
            :class-body: sd-font-weight-bold

            {% if dependency in packages %}
            :fa:`cube` :ref:`pkg-{{ dependency }}`
            {% else %}
            .. the package is not in the registry, fortunately we have an URL
            :fab:`git-alt` `{{ dependency }} <{{ url.get("git") }}>`_
            {% endif %}

         {% endfor %}
      {% endif %}
   {% endfor %}
   {% endfor %}
