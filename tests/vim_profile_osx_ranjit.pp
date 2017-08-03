include vim
vim::vim_profile { 'ranjit':
  vim_group   => 'staff',
  puppet_lint => '/Users/ranjit/.rbenv/shims/puppet-lint',
}
