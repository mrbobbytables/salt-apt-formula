enable-apt-ppa-support:
  pkg.installed:
{% if grains.osfullname == 'Ubuntu' %}
    - name: python-software-properties
{% elif grains.osfullname == 'Debian' %}
    - name: software-properties-common
{% endif %}
