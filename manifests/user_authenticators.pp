# === Define: brocadevtm::user_authenticators
#
# User Authenticator
# A user authenticator is used to allow access to the UI and REST API by
# querying a remote authentication service.
#
# === Parameters
#
# [*basic__description*]
# A description of the authenticator.
#
# [*basic__enabled*]
# Whether or not this authenticator is enabled.
#
# [*basic__type*]
# The type and protocol used by this authentication service.
#
# [*ldap__base_dn*]
# The base DN (Distinguished Name) under which directory searches will be
# applied.  The entries for your users should all appear under this DN. An
# example of a typical base DN is: "OU=users, DC=mycompany, DC=local"
#
# [*ldap__bind_dn*]
# Template to construct the bind DN (Distinguished Name) from the username.
# The string "%u" will be replaced by the username.  Examples:
# "%u@mycompany.local" for Active Directory or "cn=%u, dc=mycompany, dc=local"
# for both LDAP and Active Directory.
#
# [*ldap__dn_method*]
# The bind DN (Distinguished Name) for a user can either be searched for in
# the directory using the *base distinguished name* and *filter* values, or it
# can be constructed from the username.
#
# [*ldap__fallback_group*]
# If the *group attribute* is not defined, or returns no results for the user
# logging in, the group named here will be used. If not specified, users will
# be denied access to the traffic manager if no groups matching a Permission
# Group can be found for them in the directory.
#
# [*ldap__filter*]
# A filter that can be used to extract a unique user record located under the
# base DN (Distinguished Name).  The string "%u" will be replaced by the
# username. This filter is used to find a user's bind DN when *dn_method* is
# set to "Search", and to extract group information if the *group filter* is
# not specified. Examples: "sAMAccountName=%u" for Active Directory, or
# "uid=%u" for some Unix LDAP schemas.
#
# [*ldap__group_attribute*]
# The LDAP attribute that gives a user's group. If there are multiple entries
# for the attribute all will be extracted and they'll be lexicographically
# sorted, then the first one to match a Permission Group name will be used.
#
# [*ldap__group_field*]
# The sub-field of the group attribute that gives a user's group. For example,
# if *group_attribute* is "memberOf" and this retrieves values of the form
# "CN=mygroup, OU=groups, OU=users, DC=mycompany, DC=local" you would set
# group_field to "CN".  If there are multiple matching fields only the first
# matching field will be used.
#
# [*ldap__group_filter*]
# If the user record returned by *filter* does not contain the required group
# information you may specify an alternative group search filter here. This
# will usually be required if you have Unix/POSIX-style user records. If
# multiple records are returned the list of group names will be extracted from
# all of them. The string "%u" will be replaced by the username. Example:
# "(&(memberUid=%u)(objectClass=posixGroup))"
#
# [*ldap__port*]
# The port to connect to the LDAP server on.
#
# [*ldap__search_dn*]
# The bind DN (Distinguished Name) to use when searching the directory for a
# user's bind DN.  You can leave this blank if it is possible to perform the
# bind DN search using an anonymous bind.
#
# [*ldap__search_password*]
# If binding to the LDAP server using "search_dn" requires a password, enter
# it here.
#
# [*ldap__server*]
# The IP or hostname of the LDAP server.
#
# [*ldap__timeout*]
# Connection timeout in seconds.
#
# [*radius__fallback_group*]
# If no group is found using the vendor and group identifiers, or the group
# found is not valid, the group specified here will be used.
#
# [*radius__group_attribute*]
# The RADIUS identifier for the attribute that specifies an account's group.
# May be left blank if *fallback group* is specified.
#
# [*radius__group_vendor*]
# The RADIUS identifier for the vendor of the RADIUS attribute that specifies
# an account's group.  Leave blank if using a standard attribute (i.e. for
# Filter-Id set group_attribute to 11).
#
# [*radius__nas_identifier*]
# This value is sent to the RADIUS server.
#
# [*radius__nas_ip_address*]
# This value is sent to the RADIUS server, if left blank the address of the
# interfaced used to connect to the server will be used.
#
# [*radius__port*]
# The port to connect to the RADIUS server on.
#
# [*radius__secret*]
# Secret key shared with the RADIUS server.
#
# [*radius__server*]
# The IP or hostname of the RADIUS server.
#
# [*radius__timeout*]
# Connection timeout in seconds.
#
# [*tacacs_plus__auth_type*]
# Authentication type to use.
#
# [*tacacs_plus__fallback_group*]
# If "group_service" is not used, or no group value is provided for the user
# by the TACACS+ server, the group specified here will be used. If this is not
# specified, users with no TACACS+ defined group will be denied access.
#
# [*tacacs_plus__group_field*]
# The TACACS+ "service" field that provides each user's group.
#
# [*tacacs_plus__group_service*]
# The TACACS+ "service" that provides each user's group field.
#
# [*tacacs_plus__port*]
# The port to connect to the TACACS+ server on.
#
# [*tacacs_plus__secret*]
# Secret key shared with the TACACS+ server.
#
# [*tacacs_plus__server*]
# The IP or hostname of the TACACS+ server.
#
# [*tacacs_plus__timeout*]
# Connection timeout in seconds.
#
# === Examples
#
# brocadevtm::user_authenticators { 'example':
#     ensure => present,
#     basic__type => 'foo'
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
define brocadevtm::user_authenticators (
  $ensure,
  $basic__type,
  $basic__description          = undef,
  $basic__enabled              = false,
  $ldap__base_dn               = undef,
  $ldap__bind_dn               = undef,
  $ldap__dn_method             = 'none',
  $ldap__fallback_group        = undef,
  $ldap__filter                = undef,
  $ldap__group_attribute       = undef,
  $ldap__group_field           = undef,
  $ldap__group_filter          = undef,
  $ldap__port                  = 389,
  $ldap__search_dn             = undef,
  $ldap__search_password       = undef,
  $ldap__server                = undef,
  $ldap__timeout               = 30,
  $radius__fallback_group      = undef,
  $radius__group_attribute     = 1,
  $radius__group_vendor        = 7146,
  $radius__nas_identifier      = undef,
  $radius__nas_ip_address      = undef,
  $radius__port                = 1812,
  $radius__secret              = undef,
  $radius__server              = undef,
  $radius__timeout             = 30,
  $tacacs_plus__auth_type      = 'pap',
  $tacacs_plus__fallback_group = undef,
  $tacacs_plus__group_field    = 'permission-group',
  $tacacs_plus__group_service  = 'zeus',
  $tacacs_plus__port           = 49,
  $tacacs_plus__secret         = undef,
  $tacacs_plus__server         = undef,
  $tacacs_plus__timeout        = 30,
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring user_authenticators ${name}")
  vtmrest { "user_authenticators/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/user_authenticators.erb'),
    type     => 'application/json',
    internal => 'user_authenticators',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/user_authenticators", {ensure => present})
    file_line { "user_authenticators/${name}":
      line => "user_authenticators/${name}",
      path => "${purge_state_dir}/user_authenticators",
    }
  }
}
