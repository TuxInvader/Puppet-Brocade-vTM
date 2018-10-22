# === Define: brocadevtm::ssl_cas
#
# SSL Trusted Certificate
# SSL certificate authority certificates (CAs) and certificate revocation
# lists (CRLs) can be used when validating server and client certificates.
#
# === Parameters
#
# === Examples
#
# brocadevtm::ssl_cas { 'example':
#     ensure => present,
# }
#
#
# === Authors
#
# Mark Boddington <mbodding@brocade>
#
# === Copyright
#
# Copyright 2015 Brocade
#
define brocadevtm::ssl_cas (
  $ensure,
  $content,
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring ssl_cas ${name}")
  vtmrest { "ssl/cas/${name}":
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
    ensure_resource('file', "${purge_state_dir}/ssl_cas", {ensure => present})
    file_line { "ssl/cas/${name}":
      line => "ssl/cas/${name}",
      path => "${purge_state_dir}/ssl_cas",
    }
  }
}
