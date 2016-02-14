{% from 'apt/map.jinja' import apt_settings with context %}

include:
{% if apt_settings.ppa == true %}
  - apt.ppa
{% endif %}
{% if apt_settings.unattended_upgrades == true %}
  - apt.unattended
{% endif %}
{% for transport in apt_settings.transports %}
  - apt.transports.{{ transport }}
 {% endfor %}

{% for key, value in apt_settings.get('config').iteritems() %}
{% if value.mode == 'create' %}
create-apt-config-{{ key }}:
  file.managed:
    - name: /etc/apt/apt.conf.d/{{ key }}
    - source: salt://apt/templates/apt-conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        conf_lookup: {{ key }}
{% elif value.mode == 'append' %}
append-apt-config-{{ key }}:
  file.append:
    - name: /etc/apt/apt.conf.d/{{ key }}
    - source: salt://apt/templates/apt-conf.jinja
    - template: jinja
    - context:
        conf_lookup: {{ key }}
{% endif %}
{% endfor %}
