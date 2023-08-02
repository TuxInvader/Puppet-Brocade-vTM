# === Define: brocadevtm::ssl_admin_cas
#
# Admin SSL Trusted Certificate
# The "conf/ssl/admin_cas" directory contains SSL certificate authority
# certificates (CAs) and certificate revocation lists (CRLs) which can be used
# when validating connections made by the admin server for user
# authentication. CAs and CRLs can be managed under the "Catalogs > SSL >
# Admin CAs and CRLs" section of the Admin Server UI or by using functions
# under the "Catalog.SSL.AdminCertificateAuthorities" section of the SOAP API
# and CLI.
#
# === Parameters
#
# === Examples
#
# brocadevtm::ssl_admin_cas { 'example':
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
define brocadevtm::ssl_admin_cas (
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

  info ("Configuring ssl_admin_cas ${name}")
  vtmrest { "ssl/admin_cas/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/8.3/config/active",
    username => $user,
    password => $pass,
    content  => $content,
    type     => 'application/octet-stream',
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/ssl_admin_cas", {ensure => present})
    file_line { "ssl/admin_cas/${name}":
      line => "ssl/admin_cas/${name}",
      path => "${purge_state_dir}/ssl_admin_cas",
    }
  }
}
