# === class: brocadevtm::aptimizer_profiles_sharepoint_2013_custom_website
#
# This class is a direct implementation of brocadvtm::aptimizer_profiles
#
# Please refer to the documentation in that module for more information
#
class brocadevtm::aptimizer_profiles_sharepoint_2013_custom_website (
  $ensure                                    = present,
  $basic__background_after                   = 0,
  $basic__background_on_additional_resources = false,
  $basic__mode                               = 'active',
  $basic__show_info_bar                      = true,
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring aptimizer_profiles_sharepoint_2013_custom_website ${name}")
  vtmrest { 'aptimizer/profiles/SharePoint%202013%20Custom%20Website':
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/aptimizer_profiles.erb'),
    type     => 'application/json',
    internal => 'aptimizer_profiles_sharepoint_2013_custom_website',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/aptimizer_profiles", {ensure => present})
    file_line { 'aptimizer/profiles/SharePoint%202013%20Custom%20Website':
      line => 'aptimizer/profiles/SharePoint%202013%20Custom%20Website',
      path => "${purge_state_dir}/aptimizer_profiles",
    }
  }
}
