# === Define: brocadevtm::aptimizer_profiles
#
# Aptimizer Profile
# An Aptimizer profile can be applied to a HTTP virtual server to enable
# automatic web content optimization.
#
# === Parameters
#
# [*basic__background_after*]
# If Aptimizer can finish optimizing the resource within this time limit then
# serve the optimized content to the client, otherwise complete the
# optimization in the background and return the original content to the
# client. If set to 0, Aptimizer will always wait for the optimization to
# complete before sending a response to the client.
#
# [*basic__background_on_additional_resources*]
# If a web page contains resources that have not yet been optimized, fetch and
# optimize those resources in the background and send a partially optimized
# web page to clients until all resources on that page are ready.
#
# [*basic__config*]
# Placeholder to be overwritten when we have Aptimizer support in RESTD
#
# [*basic__mode*]
# Set the Aptimizer mode to turn acceleration on or off.
#
# [*basic__show_info_bar*]
# Show the Aptimizer information bar on aptimized web pages. This requires
# HTML optimization to be enabled in the Acceleration settings.
#
# === Examples
#
# brocadevtm::aptimizer_profiles { 'example':
#     ensure => present,
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
define brocadevtm::aptimizer_profiles (
  $ensure,
  $basic__background_after                   = 0,
  $basic__background_on_additional_resources = false,
  $basic__mode                               = 'active',
  $basic__show_info_bar                      = false,
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring aptimizer_profiles ${name}")
  vtmrest { "aptimizer/profiles/${name}":
    ensure   => $ensure,
    before   => Class[Brocadevtm::Purge],
    endpoint => "https://${ip}:${port}/api/tm/3.3/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/aptimizer_profiles.erb'),
    type     => 'application/json',
    internal => 'aptimizer_profiles',
    debug    => 0,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/aptimizer_profiles", {ensure => present})
    file_line { "aptimizer/profiles/${name}":
      line => "aptimizer/profiles/${name}",
      path => "${purge_state_dir}/aptimizer_profiles",
    }
  }
}