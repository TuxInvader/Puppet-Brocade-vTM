# === Class: brocadevtm::rules_application_firewall_enforcer

class brocadevtm::rules_application_firewall_enforcer (
  $ensure = present,
  $content = file('brocadevtm/rules_application_firewall_enforcer.data'),
){
  include brocadevtm
  $ip      = $brocadevtm::rest_ip
  $port    = $brocadevtm::rest_port
  $user    = $brocadevtm::rest_user
  $pass    = $brocadevtm::rest_pass

  info ("Configuring rules_application_firewall_enforcer ${name}")
  vtmrest { "rules/Application%20Firewall%20Enforcer":
    ensure     => $ensure,
    endpoint   => "https://${ip}:${port}/api/tm/3.3/config/active",
    username   => $user,
    password   => $pass,
    content    => $content,
    type       => 'application/octet-stream',
    debug      => 0,
  }
}
