# === Define: brocadevtm::appliance_nat
#

define brocadevtm::appliance_nat (
  $ensure,
  $basic__many_to_one_all_ports   = [],
  $basic__many_to_one_port_locked = [],
  $basic__one_to_one              = [],
  $basic__port_mapping            = [],
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring appliance_nat ${name}")
  vtmrest { "appliance/nat/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/appliance_nat.erb'),
    internal => 'appliance_nat',
    debug => 0,
  }
}
