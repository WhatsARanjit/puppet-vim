class vim::params {

  case $::osfamily {
    'redhat': {
      $vim_package = {
        'vim-common' => {
          'ensure' => 'installed',
        },
        'vim-enhanced' => {
          'ensure' => 'installed',
        },
      }
    }
    'debian': {
      $vim_package = {
        'vim-common' => {
          'ensure'   => 'purged',
        },
        'vim-enhanced' => {
          'ensure'     => 'installed',
          'require'    => 'Package["vim-common"]',
        },
      }
    }
  }

  if $::is_pe {
    $gem_prov = 'pe_gem'
  } else {
    $gem_prov = 'gem'
  }

}


