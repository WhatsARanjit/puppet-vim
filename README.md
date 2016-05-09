[![Build Status](https://travis-ci.org/WhatsARanjit/puppet-vim.svg)](https://travis-ci.org/WhatsARanjit/puppet-vim)

# Vim Module

## Overview

This will setup and install vim with some a custom .vimrc and .vim directory that allow you to write Puppet code with ease.

## Capabilities

Installalation includes:

- vim-common
- vim-enhanced

Requires:

- *nix operating system

## Vim_Profile Parameters

* `user`<br />
The user for which you want to install custom vim plugins and bundles. Default: `$name`

* `group`<br />
The group which should own the files laid down by the module in the user's home directory. Default: `$name`

* `puppet_lint`<br />
The path to puppet-lint for auto-style checking.  If you don't want puppet-lint installed, set to false. If your path is non-standard, set it here.  Default: `/usr/bin/puppet-lint` for open source; `/opt/puppet/bin/puppet-lint` for PE

* `color`<br />
Colorscheme to use for vim profile. Default: `xoria256`

## Example Usage

Install vim:

```puppet
include vim
```

Install vim_profile for root user:

```puppet
vim::vim_profile { 'root': }
```

Install vim_profile for user foo:

```puppet
vim::vim_profile { 'foo': }
```

Install vim_profile for user foo with custom puppet-lint path:

```puppet
vim::vim_profile { 'foo':
  puppet_lint => '/sbin/puppet-lint',
}
```

Install vim_profile for user foo with group bar:

```puppet
vim::vim_profile { 'foo':
  group => 'bar',
}
```

Install vim_profile for user foo with no puppet-lint testing:

```puppet
vim::vim_profile { 'foo':
  puppet_lint => false,
}
```

## Custom key mappings

* `,a`  Line up stanza on `=` signs
* `,s`  Line up stanza on `=>` signs
* `,q`  Single quote attribute value: `attribute => 'value',`
* `,q`  Remove single quotes from attribute value: `attribute => value,`
* `,w`  Double quote attribute value: `attribute => "value",`
* `,W`  Remove double quotes from attribute value: `attribute => value,`
