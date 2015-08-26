# == Define: brocadevtm
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
# === Examples
#
#  class { 'brocadevtm':
#     rest_user => 'puppet',
#     rest_pass => 'master',
#  }
#

class brocadevtm (
  $rest_user   = undef,
  $rest_pass   = undef,
  $rest_ip     = '127.0.0.1',
  $rest_port   = '9070',
) {

  if ( $rest_user == undef ) {
    fail('You must provide a $rest_user')
  }

  if ( $rest_pass == undef) {
    fail('You must provide a $rest_pass')
  }

}

