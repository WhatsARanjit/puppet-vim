define vim::vim_profile (
  $vim_user    = $name,
  $vim_group   = $name,
  $puppet_lint = true,
  $color       = 'xoria256',
  $home        = false,
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
  }

  if $home {
    $home_prefix = $home
  } else {
    if $name == 'root' {
      $home_prefix = $::osfamily ? {
        'Darwin' => '/var/root',
        default  => '/root',
      }
    } else {
      $home_prefix = $::osfamily ? {
        'Darwin' => "/Users/${name}",
        default  => "/home/${name}",
      }
    }
  }

  file { "${home_prefix}/.vimrc":
    content => template("${module_name}/dotvimrc.erb"),
  }

  file { "${home_prefix}/.vim":
    ensure  => directory,
    recurse => remote,
    source  => "puppet:///modules/${module_name}/dotvim",
  }

}
