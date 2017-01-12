## 2017-01-12 - Release 0.3.0
### Summary

Moved module from params.pp to data-in-module.

#### Improvements
* Default for `gem_prov` is the embedded `puppet_gem` provider
* Inputs are now data-typed
* Module requires `stdlib` for the `Stdlib::Absolutepath` date type
* Template for the .vimrc is now EPP-driven
