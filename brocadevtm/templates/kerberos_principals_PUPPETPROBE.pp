# === Define: brocadevtm::kerberos_principals_PUPPETPROBE
#

define brocadevtm::kerberos_principals_PUPPETPROBE (
  $ensure,
  $basic__kdcs     = [],
  $basic__keytab   = "PUPPETPROBE",
  $basic__krb5conf = "",
  $basic__realm    = "",
  $basic__service  = "PUPPETPROBE",
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring kerberos_principals_PUPPETPROBE ${name}")
  vtmrest { "kerberos/principals/PUPPETPROBE/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/kerberos_principals_PUPPETPROBE.erb'),
    debug => 0,
  }
}
