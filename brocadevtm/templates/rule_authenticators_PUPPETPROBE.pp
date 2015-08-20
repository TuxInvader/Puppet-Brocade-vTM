# === Define: brocadevtm::rule_authenticators_PUPPETPROBE
#

define brocadevtm::rule_authenticators_PUPPETPROBE (
  $ensure,
  $basic__host          = "",
  $basic__note          = "",
  $basic__port          = 389,
  $ldap__attributes     = [],
  $ldap__bind_dn        = "",
  $ldap__bind_password  = "",
  $ldap__filter         = "",
  $ldap__filter_base_dn = "",
  $ldap__ssl_cert       = "",
  $ldap__ssl_enabled    = false,
  $ldap__ssl_type       = "ldaps",
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring rule_authenticators_PUPPETPROBE ${name}")
  vtmrest { "rule_authenticators/PUPPETPROBE/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/rule_authenticators_PUPPETPROBE.erb'),
    debug => 0,
  }
}
