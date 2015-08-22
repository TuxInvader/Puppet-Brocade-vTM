# === Class: brocadevtm::aptimizer_profiles_advanced
#
# This class is a direct implementation of brocadvtm::aptimizer_profiles
#
# Please refer to the documentation in that module for more information
#
class brocadevtm::aptimizer_profiles_advanced (
  $ensure = present,
  $basic__background_after                   = 0,
  $basic__background_on_additional_resources = false,
  $basic__mode                               = "active",
  $basic__show_info_bar                      = true,
){
  include brocadevtm
  $ip   = $brocadevtm::rest_ip
  $port = $brocadevtm::rest_port
  $user = $brocadevtm::rest_user
  $pass = $brocadevtm::rest_pass

  info ("Configuring aptimizer_profiles_advanced ${name}")
  vtmrest { "aptimizer/profiles/Advanced":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    content => template('brocadevtm/aptimizer_profiles.erb'),
    type => 'application/json',
    internal => 'aptimizer_profiles_advanced',
    debug => 0,
  }
}
