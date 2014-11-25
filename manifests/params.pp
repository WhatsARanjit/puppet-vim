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
        'vim' => {
          'ensure' => 'installed',
        },
        'vim-common' => {
          'ensure'   => 'installed',
        },
      }
    }
    default: { $vim_package = {} }
  }

  if $::is_pe {
    $gem_prov = 'pe_gem'
  } else {
    $gem_prov = 'gem'
  }

}


