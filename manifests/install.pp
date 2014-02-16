class vim::install {
  package { [ "vim-common", "vim-enhanced" ]:
    ensure => installed,
  }
}


