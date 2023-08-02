# === class: brocadevtm::servicediscovery_builtin_dns_stateless

class brocadevtm::servicediscovery_builtin_dns_stateless (
  $ensure  = present,
  $content = file('brocadevtm/servicediscovery_builtin_dns_stateless.data'),
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring servicediscovery_builtin_dns_stateless ${name}")
  vtmrest { 'servicediscovery/BuiltIn-DNS_Stateless':
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
    file_line { 'servicediscovery/BuiltIn-DNS_Stateless':
      line => 'servicediscovery/BuiltIn-DNS_Stateless',
      path => "${purge_state_dir}/servicediscovery",
    }
  }
}
