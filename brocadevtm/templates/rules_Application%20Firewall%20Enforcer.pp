# === Define: brocadevtm::rules_Application%20Firewall%20Enforcer
#

define brocadevtm::rules_Application%20Firewall%20Enforcer (
  $ensure,
  $file,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring rules_Application%20Firewall%20Enforcer ${name}")
  vtmrest { "rules/Application%20Firewall%20Enforcer/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => file($file),
    type => 'application/octet-stream',
    debug => 0,
  }
}
