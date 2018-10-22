# === Define: brocadevtm::ssl_ticket_keys
#
# SSL Ticket Key
# Configuration for SSL ticket encryption keys when managed externally via the
# ssl/ticket_keys REST API endpoints.
#
# === Parameters
#
# [*basic__algorithm*]
# The algorithm used to encrypt session tickets.  The algorithm determines the
# length of the key that must be provided.
#
# [*basic__id*]
# A 16-byte key identifier, with each byte encoded as two hexadecimal digits.
# Key identifiers are transmitted in plaintext at the beginning of a TLS
# session ticket, and are used to identify the ticket encryption key that was
# used to encrypt a ticket. (They correspond to the 'key_name' field in RFC
# 5077.) They are required to be unique across the set of SSL ticket
# encryption keys.
#
# [*basic__key*]
# The session ticket encryption key, with each byte encoded as two hexadecimal
# digits. The required key length is determined by the chosen key algorithm.
# See the documentation for the 'algorithm' field for more details.
#
# [*basic__validity_end*]
# The latest time at which this key may be used to encrypt new session
# tickets. Given as number of seconds since the epoch (1970-01-01T00:00:00Z).
#
# [*basic__validity_start*]
# The earliest time at which this key may be used to encrypt new session
# tickets. Given as number of seconds since the epoch (1970-01-01T00:00:00Z).
#
# === Examples
#
# brocadevtm::ssl_ticket_keys { 'example':
#     ensure => present,
#     basic__id => 'foo'
#     basic__key => 'foo'
#     basic__validity_end => 8888
#     basic__validity_start => 8888
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
define brocadevtm::ssl_ticket_keys (
  $ensure,
  $basic__id,
  $basic__key,
  $basic__validity_end,
  $basic__validity_start,
  $basic__algorithm      = 'aes_256_cbc_hmac_sha256',
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring ssl_ticket_keys ${name}")
  vtmrest { "ssl/ticket_keys/${name}":
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/ssl_ticket_keys.erb'),
    type     => 'application/json',
    internal => 'ssl_ticket_keys',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/ssl_ticket_keys", {ensure => present})
    file_line { "ssl/ticket_keys/${name}":
      line => "ssl/ticket_keys/${name}",
      path => "${purge_state_dir}/ssl_ticket_keys",
    }
  }
}
