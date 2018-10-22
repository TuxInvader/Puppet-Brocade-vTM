# === class: brocadevtm::rules_application_firewall_enforcer

class brocadevtm::rules_application_firewall_enforcer (
  $ensure  = present,
  $content = file('brocadevtm/rules_application_firewall_enforcer.data'),
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring rules_application_firewall_enforcer ${name}")
  vtmrest { 'rules/Application%20Firewall%20Enforcer':
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => $content,
    type     => 'application/octet-stream',
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/rules", {ensure => present})
    file_line { 'rules/Application%20Firewall%20Enforcer':
      line => 'rules/Application%20Firewall%20Enforcer',
      path => "${purge_state_dir}/rules",
    }
  }
}
