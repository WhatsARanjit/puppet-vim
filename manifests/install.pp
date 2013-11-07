class vim::install {
  package { [ "vim-common", "vim-enhanced" ]:
    ensure => installed,
  }
  define vim_profile (
    $user = "$name",
    $group = "$name",

  ){
    $home = $user ? {
      'root'  => '/root',
      default => "/home/${name}",
    }
    file { "${home}/.vimrc":
      ensure  => present,
      owner   => $user,
      group   => $group,
      source  => "puppet:///modules/${module_name}/dotvimrc",
      require => Package['vim-common'],
    }
    file { "${home}/.vim":
      ensure  => directory,
      recurse => remote,
      owner   => $user,
      group   => $group,
      source  => "puppet:///modules/${module_name}/dotvim",
      require => Package['vim-common'],
    }
  }
}


