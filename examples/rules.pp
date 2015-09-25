class { 'brocadevtm':
  rest_user  => 'puppet',
  rest_pass  => 'master',
  rest_ip    => '10.1.1.22',
}

brocadevtm::rules { 'testRule':
  ensure     => present,
  content    => file('brocadevtm/testrule.zts'),
}

