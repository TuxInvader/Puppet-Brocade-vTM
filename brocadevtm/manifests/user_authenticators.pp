# === Define: brocadevtm::user_authenticators
#

define brocadevtm::user_authenticators (
  $ensure,
  $basic__type,
  $basic__description          = "",
  $basic__enabled              = false,
  $ldap__base_dn               = "",
  $ldap__bind_dn               = "",
  $ldap__dn_method             = "none",
  $ldap__fallback_group        = "",
  $ldap__filter                = "",
  $ldap__group_attribute       = "",
  $ldap__group_field           = "",
  $ldap__group_filter          = "",
  $ldap__port                  = 389,
  $ldap__search_dn             = "",
  $ldap__search_password       = "",
  $ldap__server                = "",
  $ldap__timeout               = 30,
  $radius__fallback_group      = "",
  $radius__group_attribute     = 1,
  $radius__group_vendor        = 7146,
  $radius__nas_identifier      = "",
  $radius__nas_ip_address      = "",
  $radius__port                = 1812,
  $radius__secret              = "",
  $radius__server              = "",
  $radius__timeout             = 30,
  $tacacs_plus__auth_type      = "pap",
  $tacacs_plus__fallback_group = "",
  $tacacs_plus__group_field    = "permission-group",
  $tacacs_plus__group_service  = "zeus",
  $tacacs_plus__port           = 49,
  $tacacs_plus__secret         = "",
  $tacacs_plus__server         = "",
  $tacacs_plus__timeout        = 30,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring user_authenticators ${name}")
  vtmrest { "user_authenticators/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => template('brocadevtm/user_authenticators.erb'),
    type => 'application/json',
    internal => 'user_authenticators',
    debug => 0,
  }
}
