define vim::vim_profile (
  $vim_user    = $name,
  $vim_group   = $name,
  $puppet_lint = true,
  $color       = 'xoria256',
){
  case $puppet_lint {
    true: {
      if $::is_pe {
        $puppet_lint_path = '/opt/puppet/bin/puppet-lint'
      } else {
        $puppet_lint_path = '/usr/bin/puppet-lint'
      }
    }
    false: {
      $puppet_lint_path = false
    }
    default: {
      $puppet_lint_path = $puppet_lint
    }
  }
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
