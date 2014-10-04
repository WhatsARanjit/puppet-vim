class vim::install {
  package { [ 'vim-common', 'vim-enhanced' ]:
    ensure => installed,
  }
  if $::is_pe {
    $gem_prov = 'pe_gem'
  } else {
    $gem_prov = 'gem'
  }
  package { 'puppet-lint':
    ensure   => installed,
    provider => $gem_prov,
  }
}


