# === Define: brocadevtm::monitor_scripts_PUPPETPROBE
#

define brocadevtm::monitor_scripts_PUPPETPROBE (
  $ensure,
  $file,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring monitor_scripts_PUPPETPROBE ${name}")
  vtmrest { "monitor_scripts/PUPPETPROBE/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => file($file),
    type => 'application/octet-stream',
    debug => 0,
  }
}
