class vim::install {
  package { [ "vim-common", "vim-enhanced" ]:
    ensure => installed,
  }
  package { 'puppet-lint':
    ensure   => installed,
    provider => 'gem',
  }
}


