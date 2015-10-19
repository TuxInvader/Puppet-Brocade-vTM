# === Class: brocadevtm
#
# This defines the Brocade vTM access information.
#
# === Parameters
#
# [*rest_user*]
# The REST user for configuring this vTM
#
# [*rest_pass*]
# The cleartext password for the REST user.
#
# [*rest_ip*]
# The IP Address where the REST API is listening
#
# [*rest_port*]
# The REST API port.
#
# [*purge*]
# Boolean. Should unmanaged configuration be removed from the vTM?
#
# [*purge_state_dir*]
# State directory for tracking managed configuration
#
# [*failfast*]
# Should the module report an object misconfiguration ASAP or should we compare all 
# attributes before reporting the error? Defaults to true (fail fast).
# Set this to false if you want to log all differences between the object and the manifest.
#
# === Examples
#
#  class { 'brocadevtm':
#     rest_user        => 'puppet',
#     rest_pass        => 'master',
#     purge            => true,
#     purge_state_dir  => '/var/run/brocadevtm_state',
#  }
#

class brocadevtm (
  $rest_user       = undef,
  $rest_pass       = undef,
  $purge_state_dir = undef,
  $rest_ip         = '127.0.0.1',
  $rest_port       = '9070',
  $purge           = false,
  $failfast        = true,
) {

  if ( $rest_user == undef ) {
    fail('You must provide a $rest_user')
  }

  if ( $rest_pass == undef) {
    fail('You must provide a $rest_pass')
  }

  include brocadevtm::purge
  if ( $purge ) {
    if ( $purge_state_dir == undef ) {
      fail('You must set a $purge_state_dir if using $purge = true')
    }
    file { $purge_state_dir:
      ensure  => directory,
    }
  }

}

