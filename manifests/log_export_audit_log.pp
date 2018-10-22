# === class: brocadevtm::log_export_audit_log
#
# This class is a direct implementation of brocadvtm::log_export
#
# Please refer to the documentation in that module for more information
#
class brocadevtm::log_export_audit_log (
  $ensure                = present,
  $basic__appliance_only = false,
  $basic__enabled        = true,
  $basic__files          = '["%ZEUSHOME%/zxtm/log/audit*"]',
  $basic__history        = 'none',
  $basic__history_period = 10,
  $basic__metadata       = '[{"name":"source","value":"auditlog"},{"name":"sourcetype","value":"zxtm_audit_log"}]',
  $basic__note           = 'The traffic manager audit log.',
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring log_export_audit_log ${name}")
  vtmrest { 'log_export/Audit%20Log':
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => template('brocadevtm/log_export.erb'),
    type     => 'application/json',
    internal => 'log_export_audit_log',
    failfast => $brocadevtm::failfast,
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/log_export", {ensure => present})
    file_line { 'log_export/Audit%20Log':
      line => 'log_export/Audit%20Log',
      path => "${purge_state_dir}/log_export",
    }
  }
}
