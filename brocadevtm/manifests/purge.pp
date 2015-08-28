# === Class: brocadevtm
#
# This defines the Brocade vTM access information.
#
# === Parameters
#
# === Examples
#
#  include brocadevtm::purge
#

class brocadevtm::purge {

  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  if ($purge) {
    vtmrest { 'purge':
      ensure     => present,
      endpoint   => "https://${ip}:${port}/api/tm/3.3/config/active",
      username   => $user,
      password   => $pass,
      content    => $purge_state_dir,
      type       => 'purge',
      internal   => 'none',
      debug      => 0,
    }

  }

}

