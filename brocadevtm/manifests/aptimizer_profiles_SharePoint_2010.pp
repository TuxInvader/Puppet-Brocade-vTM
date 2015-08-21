# === Class: brocadevtm::aptimizer_profiles_SharePoint_2010
#

class brocadevtm::aptimizer_profiles_SharePoint_2010 (
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

  info ("Configuring aptimizer_profiles_SharePoint_2010 ${name}")
  vtmrest { "aptimizer/profiles/SharePoint%202010":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/aptimizer_profiles_SharePoint_2010.erb'),
    internal => 'aptimizer_profiles_SharePoint_2010',
    debug => 0,
  }
}
