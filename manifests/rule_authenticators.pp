# === Define: brocadevtm::rule_authenticators
#
# TrafficScript Authenticator
# TrafficScript authenticators define remote authentication services that can
# be queried via a TrafficScript rule.
#
# === Parameters
#
# [*basic__host*]
# The hostname or IP address of the remote authenticator.
#
# [*basic__note*]
# A description of the authenticator.
#
# [*basic__port*]
# The port on which the remote authenticator should be contacted.
#
# [*ldap__attributes*]
# A list of attributes to return from the search. If blank, no attributes will
# be returned. If set to '*' then all user attributes will be returned.
# Type:array
# Properties:
#
# [*ldap__bind_dn*]
# The distinguished name (DN) of the 'bind' user. The traffic manager will
# connect to the LDAP server as this user when searching for user records.
#
# [*ldap__bind_password*]
# The password for the bind user.
#
# [*ldap__filter*]
# The filter used to locate the LDAP record for the user being authenticated.
# Any occurrences of '"%u"' in the filter will be replaced by the name of the
# user being authenticated.
#
# [*ldap__filter_base_dn*]
# The base distinguished name (DN) under which user records are located on the
# server.
#
# [*ldap__ssl_cert*]
# The SSL certificate that the traffic manager should use to validate the
# remote server. If no certificate is specified then no signature validation
# will be performed.
#
# [*ldap__ssl_enabled*]
# Whether or not to enable SSL encryption to the LDAP server.
#
# [*ldap__ssl_type*]
# The type of LDAP SSL encryption to use.
#
# === Examples
#
# brocadevtm::rule_authenticators { 'example':
#     ensure => present,
# }
#
#
# === Authors
#
# Mark Boddington <mbodding@brocade>
#
# === Copyright
#
# Copyright 2015 Brocade
#
define brocadevtm::rule_authenticators (
  $ensure,
  $basic__host          = undef,
  $basic__note          = undef,
  $basic__port          = 389,
  $ldap__attributes     = '[]',
  $ldap__bind_dn        = undef,
  $ldap__bind_password  = undef,
  $ldap__filter         = undef,
  $ldap__filter_base_dn = undef,
  $ldap__ssl_cert       = undef,
  $ldap__ssl_enabled    = false,
  $ldap__ssl_type       = 'ldaps',
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring rule_authenticators ${name}")
  vtmrest { "rule_authenticators/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/rule_authenticators.erb'),
    type     => 'application/json',
    internal => 'rule_authenticators',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/rule_authenticators", {ensure => present})
    file_line { "rule_authenticators/${name}":
      line => "rule_authenticators/${name}",
      path => "${purge_state_dir}/rule_authenticators",
    }
  }
}
