# === class: brocadevtm::servicediscovery_builtin_dns_resolver

class brocadevtm::servicediscovery_builtin_dns_resolver (
  $ensure  = present,
  $content = file('brocadevtm/servicediscovery_builtin_dns_resolver.data'),
){
  include brocadevtm
  $ip              = $brocadevtm::rest_ip
  $port            = $brocadevtm::rest_port
  $user            = $brocadevtm::rest_user
  $pass            = $brocadevtm::rest_pass
  $purge           = $brocadevtm::purge
  $purge_state_dir = $brocadevtm::purge_state_dir

  info ("Configuring servicediscovery_builtin_dns_resolver ${name}")
  vtmrest { 'servicediscovery/BuiltIn-DNS_Resolver':
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
    ensure_resource('file', "${purge_state_dir}/servicediscovery", {ensure => present})
    file_line { 'servicediscovery/BuiltIn-DNS_Resolver':
      line => 'servicediscovery/BuiltIn-DNS_Resolver',
      path => "${purge_state_dir}/servicediscovery",
    }
  }
}
