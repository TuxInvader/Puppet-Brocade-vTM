# === Class: brocadevtm::user_groups_admin
#
# This class is a direct implementation of brocadvtm::user_groups
#
# Please refer to the documentation in that module for more information
#
class brocadevtm::user_groups_admin (
  $ensure = present,
  $basic__description          = 'Full access to all pages',
  $basic__password_expire_time = 0,
  $basic__permissions          = '[{"name"=>"all", "access_level"=>"full"}]',
  $basic__timeout              = 30,
){
  include brocadevtm
  $ip      = $brocadevtm::rest_ip
  $port    = $brocadevtm::rest_port
  $user    = $brocadevtm::rest_user
  $pass    = $brocadevtm::rest_pass

  info ("Configuring user_groups_admin ${name}")
  vtmrest { 'user_groups/admin':
    ensure     => $ensure,
    endpoint   => "https://${ip}:${port}/api/tm/3.3/config/active",
    username   => $user,
    password   => $pass,
    content    => template('brocadevtm/user_groups.erb'),
    type       => 'application/json',
    internal   => 'user_groups_admin',
    debug      => 0,
  }
}
