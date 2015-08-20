# === Class: brocadevtm::rules_Application%20Firewall%20Enforcer
#

class brocadevtm::rules_Application%20Firewall%20Enforcer (
  $ensure = present,
  $file,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring rules_Application%20Firewall%20Enforcer ${name}")
  vtmrest { "rules/Application%20Firewall%20Enforcer":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => 'puppet:///brocadevtm/rules_Application%20Firewall%20Enforcer.data',
    type => 'application/octet-stream',
    debug => 0,
  }
}
