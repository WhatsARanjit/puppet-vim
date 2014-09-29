define vim::vim_profile (
  $vim_user  = $name,
  $vim_group = $name,
  $puppet_lint = '/usr/bin/puppet-lint'
){
  File {
    ensure  => file,
    owner   => $vim_user,
    group   => $vim_group,
    require => Package['vim-common'],
  }
  $home = $vim_user ? {
    'root'  => '/root',
    default => "/home/${name}",
  }
  file { "${home}/.vimrc":
    content => template("${module_name}/dotvimrc.erb"),
  }
  file { "${home}/.vim":
    ensure  => directory,
    recurse => remote,
    source  => "puppet:///modules/${module_name}/dotvim",
  }
}
