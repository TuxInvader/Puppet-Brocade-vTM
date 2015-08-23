class { 'brocadevtm':
  rest_user   => 'puppet',
  rest_pass   => 'master',
  rest_ip     => '10.1.1.22',
}

brocadevtm::virtual_servers { 'vserver1':
  ensure      => present,
  basic__pool => 'puppetPool',
  basic__port => 80,
}

