# === class: brocadevtm::servicediscovery_builtin_pcs_pps

class brocadevtm::servicediscovery_builtin_pcs_pps (
  $ensure  = present,
  $content = file('brocadevtm/servicediscovery_builtin_pcs_pps.data'),
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring servicediscovery_builtin_pcs_pps ${name}")
  vtmrest { 'servicediscovery/BuiltIn-PCS_PPS':
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/8.3/config/active",
    username => $user,
    password => $pass,
    content  => $content,
    type     => 'application/octet-stream',
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/servicediscovery", {ensure => present})
    file_line { 'servicediscovery/BuiltIn-PCS_PPS':
      line => 'servicediscovery/BuiltIn-PCS_PPS',
      path => "${purge_state_dir}/servicediscovery",
    }
  }
}
