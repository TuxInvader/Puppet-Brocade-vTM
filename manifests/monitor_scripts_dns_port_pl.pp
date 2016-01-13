# === Class: brocadevtm::monitor_scripts_dns_port_pl

class brocadevtm::monitor_scripts_dns_port_pl (
  $ensure  = present,
  $content = file('brocadevtm/monitor_scripts_dns_port_pl.data'),
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring monitor_scripts_dns_port_pl ${name}")
  vtmrest { 'monitor_scripts/dns_port.pl':
    ensure   => $ensure,
    before   => Class[Brocadevtm::Purge],
    endpoint => "https://${ip}:${port}/api/tm/3.6/config/active",
    username => $user,
    password => $pass,
    content  => $content,
    type     => 'application/octet-stream',
    debug    => 0,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/monitor_scripts", {ensure => present})
    file_line { 'monitor_scripts/dns_port.pl':
      line => 'monitor_scripts/dns_port.pl',
      path => "${purge_state_dir}/monitor_scripts",
    }
  }
}
