===
Apt
===

Formula for managing apt and it's associated transports.

Tested with the following platforms:

- Debian 7 (Wheezy)
- Debian 8 (Jessie)
- Ubuntu 12.04 (Precise)
- Ubuntu 14.04 (Trusty)
- Ubuntu 15.04 (Vivid)
- Ubuntu 15.10 (Wily)
- Ubuntu 16.04 (Xenial)

----

.. contents::

States
======

``apt``
----------

Manages apt configuration based on pillar data.

**Variables of Note**

- **unnattended_upgrades** - Enables unattended upgrades
- **ppa** - Enables PPA support
- **transports** - A list of transports to enable (debtorrent, https, s3, spacewalk). 
- **config** - A hash of apt config files to update or modify.

The ``config`` block uses the following syntax:

::

  apt:
    lookup:
      config:
        <name of apt config file>:
          mode: <create|append>
          params:
            - name: <parameter name>
              value:
                - <value 1>
                - <value 2>


**Pillar Example:**

::

  apt:
    lookup:
      unattended_upgrades: true
      ppa: true
      transports:
        - https
      config:
        50unattended-upgrades:
          mode: create
          params:
            - name: Unattended-Upgrade::Allowed-Origins
              value:
                - ${distro_id}:${distro_codename}-security
        99timeout:
          mode: create
          params:
            - name: Acquire:ftp::Timeout
              value:
                - 10
            - name: Acquire::http::Timeout
              value:
                - 10
            - name: Acquire::https::Timeout
              value:
                - 10

----

``apt.dist_upgrade``
------------------

Performs a dist upgrade ( ``apt-get dist-upgrade``)

----

``apt.ppa``
-----------

Enables PPA support by installing the appropriate package(s).

----

``apt.unattended``
------------------

Enables unattended-upgrades by installing the appropriate package.

**NOTE:** Does not configure unattended-upgrades.

----

``apt.update``
--------------

Performs an apt update (``apt-get update``)

----

``apt.upgrade``
---------------

Performs an apt upgrade (``apt-get upgrade``)

----

``apt.transports.debtorrent``
-----------------------------

Enables debtorrent support (``apt-transport-debtorrent``)

**NOTE:** Does not check to see if the distro itself supports it.

----

``apt.transports.https``
-----------------------------

Enables apt-https support (``apt-transport-https``)

**NOTE:** Does not check to see if the distro itself supports it.

----

``apt.transports.s3``
-----------------------------

Enables apt-s3 support (``apt-transport-s3``)

**NOTE:** Does not check to see if the distro itself supports it.

----

``apt.transports.spacewalk``
-----------------------------

Enables apt-spacewalk support (``apt-transport-spacewalk``)

**NOTE:** Does not check to see if the distro itself supports it.

