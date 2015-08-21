# === Define: brocadevtm::kerberos_principals
#

define brocadevtm::kerberos_principals (
  $ensure,
  $basic__keytab,
  $basic__service,
  $basic__kdcs     = [],
  $basic__krb5conf = "",
  $basic__realm    = "",
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring kerberos_principals ${name}")
  vtmrest { "kerberos/principals/${name}":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => template('brocadevtm/kerberos_principals.erb'),
    type => 'application/json',
    internal => 'kerberos_principals',
    debug => 0,
  }
}
