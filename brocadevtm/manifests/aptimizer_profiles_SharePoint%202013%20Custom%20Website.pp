# === Class: brocadevtm::aptimizer_profiles_SharePoint%202013%20Custom%20Website
#

class brocadevtm::aptimizer_profiles_SharePoint%202013%20Custom%20Website (
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

  info ("Configuring aptimizer_profiles_SharePoint%202013%20Custom%20Website ${name}")
  vtmrest { "aptimizer/profiles/SharePoint%202013%20Custom%20Website":
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    ensure => $ensure,
    username => $user,
    password => $pass,
    type => 'application/json',
    content => template('brocadevtm/aptimizer_profiles_SharePoint%202013%20Custom%20Website.erb'),
    internal => 'aptimizer_profiles_SharePoint%202013%20Custom%20Website',
    debug => 0,
  }
}
