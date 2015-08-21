# === Class: brocadevtm::rules_Application_Firewall_Enforcer
#

class brocadevtm::rules_Application_Firewall_Enforcer (
  $ensure = present,
  $file = 'puppet:///modules/brocadevtm/rules_Application_Firewall_Enforcer.data',
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring rules_Application_Firewall_Enforcer ${name}")
  vtmrest { "rules/Application%20Firewall%20Enforcer":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => file($file),
    type => 'application/octet-stream',
    debug => 0,
  }
}
