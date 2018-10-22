# === class: brocadevtm::monitor_scripts_dns_pl

class brocadevtm::monitor_scripts_dns_pl (
  $ensure  = present,
  $content = file('brocadevtm/monitor_scripts_dns_pl.data'),
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring monitor_scripts_dns_pl ${name}")
  vtmrest { 'monitor_scripts/dns.pl':
    ensure   => $ensure,
    before   => Class[brocadevtm::purge],
    endpoint => "https://${ip}:${port}/api/tm/6.0/config/active",
    username => $user,
    password => $pass,
    content  => $content,
    type     => 'application/octet-stream',
    debug    => $brocadevtm::debug,
  }

  if ( $purge ) {
    ensure_resource('file', "${purge_state_dir}/monitor_scripts", {ensure => present})
    file_line { 'monitor_scripts/dns.pl':
      line => 'monitor_scripts/dns.pl',
      path => "${purge_state_dir}/monitor_scripts",
    }
  }
}
