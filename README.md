[![Build Status](https://travis-ci.org/martezr/puppet-module-joindomain.svg?branch=master)](https://travis-ci.org/martezr/puppet-module-joindomain)

# puppet-module-joindomain
===

This module is used to join Microsoft Windows systems to a specified Active Directory domain.

===

# Compatibility
---------------
This module has been tested to work on the following systems with Puppet v3 and Ruby versions 1.8.7, 1.9.3, and 2.0.0.

 * Windows Server 2008
 * Windows Server 2008 R2
 * Windows Server 2012
 * Windows Server 2012 R2

===

# Parameters

domain
-----------
The Active Directory domain that the computer will join.

- *Default*: 'undef'

username
---------------------------
The username for the domain account required to join the domain.

- *Default*: 'undef'

password
---------------
The password for the domain account required to join the domain.

- *Default*: 'undef'

===

## Sample usage:
Join an Active Directory Domain

<pre>
---
classes:
  - joindomain
  
joindomain::domain:	  'test.local'
joindomain::username: 'administrator'
joindomain::password: 'P@$$w0rd1'
</pre>