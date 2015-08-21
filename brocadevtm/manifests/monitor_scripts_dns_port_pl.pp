# === Class: brocadevtm::monitor_scripts_dns_port_pl
#

class brocadevtm::monitor_scripts_dns_port_pl (
  $ensure = present,
  $content = file('brocadevtm/monitor_scripts_dns_port_pl.data'),
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring monitor_scripts_dns_port_pl ${name}")
  vtmrest { "monitor_scripts/dns_port.pl":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => $content,
    type => 'application/octet-stream',
    debug => 0,
  }
}
