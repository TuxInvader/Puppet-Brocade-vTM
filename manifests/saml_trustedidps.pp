# === Define: brocadevtm::saml_trustedidps
#
# Trusted SAML Identity Provider
# Configuration for SAML IDP trust relationships.
#
# === Parameters
#
# [*basic__add_zlib_header*]
# Whether or not to add the zlib header when compressing the AuthnRequest
#
# [*basic__certificate*]
# The certificate used to verify Assertions signed by the identity provider
#
# [*basic__entity_id*]
# The entity id of the IDP
#
# [*basic__strict_verify*]
# Whether or not SAML responses will be verified strictly
#
# [*basic__url*]
# The IDP URL to which Authentication Requests should be sent
#
# === Examples
#
# brocadevtm::saml_trustedidps { 'example':
#     ensure => present,
#     basic__certificate => 'foo'
#     basic__entity_id => 'foo'
#     basic__url => 'foo'
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
define brocadevtm::saml_trustedidps (
  $ensure,
  $basic__certificate,
  $basic__entity_id,
  $basic__url,
  $basic__add_zlib_header = false,
  $basic__strict_verify   = true,
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring saml_trustedidps ${name}")
  vtmrest { "saml/trustedidps/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/saml_trustedidps.erb'),
    type     => 'application/json',
    internal => 'saml_trustedidps',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/saml_trustedidps", {ensure => present})
    file_line { "saml/trustedidps/${name}":
      line => "saml/trustedidps/${name}",
      path => "${purge_state_dir}/saml_trustedidps",
    }
  }
}
