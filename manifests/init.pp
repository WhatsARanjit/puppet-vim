class vim (
  Hash $vim_package,
  String $gem_prov,
) {

  create_resources( 'package', $vim_package )

  package { 'puppet-lint':
    ensure   => installed,
    provider => $gem_prov,
  }

}


