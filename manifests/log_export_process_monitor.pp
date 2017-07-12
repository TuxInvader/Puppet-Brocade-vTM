# === Class: brocadevtm::log_export_process_monitor
#
# This class is a direct implementation of brocadvtm::log_export
#
# Please refer to the documentation in that module for more information
#
class brocadevtm::log_export_process_monitor (
  $ensure                = present,
  $basic__appliance_only = false,
  $basic__enabled        = false,
  $basic__files          = '["%ZEUSHOME%/zxtm/log/procmon*"]',
  $basic__history        = 'none',
  $basic__history_period = 10,
  $basic__metadata       = '[{"name":"sourcetype","value":"zxtm_procmon_log"},{"name":"source","value":"procmonlog"}]',
  $basic__note           = 'Log files maintained by the traffic manager\'s internal health montior.',
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring log_export_process_monitor ${name}")
  vtmrest { 'log_export/Process%20Monitor':
    ensure   => $ensure,
    before   => Class[Brocadevtm::Purge],
    endpoint => "https://${ip}:${port}/api/tm/5.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/log_export.erb'),
    type     => 'application/json',
    internal => 'log_export_process_monitor',
    failfast => $brocadevtm::failfast,
    debug    => 0,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/log_export", {ensure => present})
    file_line { 'log_export/Process%20Monitor':
      line => 'log_export/Process%20Monitor',
      path => "${purge_state_dir}/log_export",
    }
  }
}
