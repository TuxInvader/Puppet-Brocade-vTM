# === class: brocadevtm::extra_files_dockerscaler_py

class brocadevtm::extra_files_dockerscaler_py (
  $ensure  = present,
  $content = file('brocadevtm/extra_files_dockerscaler_py.data'),
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring extra_files_dockerscaler_py ${name}")
  vtmrest { 'extra_files/dockerScaler.py':
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
    ensure_resource('file', "${purge_state_dir}/extra_files", {ensure => present})
    file_line { 'extra_files/dockerScaler.py':
      line => 'extra_files/dockerScaler.py',
      path => "${purge_state_dir}/extra_files",
    }
  }
}
