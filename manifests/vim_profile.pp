define vim::vim_profile (
  String $vim_user                                           = $name,
  String $vim_group                                          = $name,
  Variant[Stdlib::Absolutepath, Boolean, Undef] $puppet_lint = true,
  String $color                                              = 'xoria256',
  Boolean $home                                              = false,
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
      $home_prefix = $facts['os']['family'] ? {
        'Darwin' => '/var/root',
        default  => '/root',
      }
    } else {
      $home_prefix = $facts['os']['family'] ? {
        'Darwin' => "/Users/${name}",
        default  => "/home/${name}",
      }
    }
  }

  file { "${home_prefix}/.vimrc":
    content => epp("${module_name}/dotvimrc.epp", {
      'color'            => $color,
      'puppet_lint'      => $puppet_lint,
      'puppet_lint_path' => $puppet_lint_path,
    }),
  }

  file { "${home_prefix}/.vim":
    ensure  => directory,
    recurse => remote,
    source  => "puppet:///modules/${module_name}/dotvim",
  }

}
