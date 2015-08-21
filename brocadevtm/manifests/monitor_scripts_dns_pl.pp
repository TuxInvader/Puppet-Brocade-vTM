# === Class: brocadevtm::monitor_scripts_dns_pl
#

class brocadevtm::monitor_scripts_dns_pl (
  $ensure = present,
  $file = 'puppet:///modules/brocadevtm/monitor_scripts_dns_pl.data',
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring monitor_scripts_dns_pl ${name}")
  vtmrest { "monitor_scripts/dns.pl":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => file($file),
    type => 'application/octet-stream',
    debug => 0,
  }
}