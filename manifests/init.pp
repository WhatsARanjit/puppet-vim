class vim (
  $vim_package = $::vim::params::vim_package,
  $gem_prov    = $::vim::params::gem_prov,
) inherits vim::params {

  create_resources( 'package', $vim_package )

  package { 'puppet-lint':
    ensure   => installed,
    provider => $gem_prov,
  }

}


