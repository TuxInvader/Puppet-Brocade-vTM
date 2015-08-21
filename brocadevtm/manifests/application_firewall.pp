# === Class: brocadevtm::application_firewall
#

class brocadevtm::application_firewall (
  $ensure = present,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring application_firewall ${name}")
  vtmrest { "application_firewall":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => template('brocadevtm/application_firewall.erb'),
    type => 'application/json',
    internal => 'application_firewall',
    debug => 0,
  }
}
