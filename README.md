# vim

[![GitHub license](https://img.shields.io/badge/license-GPL-blue.svg)](https://raw.githubusercontent.com/brwyatt/puppet-vim/master/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/brwyatt/puppet-vim.svg)](https://github.com/brwyatt/puppet-vim/issues)
[![GitHub forks](https://img.shields.io/github/forks/brwyatt/puppet-vim.svg)](https://github.com/brwyatt/puppet-vim/network)
[![GitHub stars](https://img.shields.io/github/stars/brwyatt/puppet-vim.svg)](https://github.com/brwyatt/puppet-vim/stargazers)

[![Puppet Forge](https://img.shields.io/puppetforge/v/brwyatt/vim.svg)](https://forge.puppetlabs.com/brwyatt/vim)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/brwyatt/vim.svg)](https://forge.puppetlabs.com/brwyatt/vim)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/brwyatt/vim.svg)](https://forge.puppetlabs.com/brwyatt/vim)

Install vim and manage user configuration files

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with vim](#setup)
    * [What vim affects](#what-vim-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with vim](#beginning-with-vim)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

This module installs vim and manages vim user configuration files. Currently, this module allows managing of user `.vimrc`, vim plugins, and Pathogen bundles.

## Setup

### What vim affects

When this module is used to manage a user's vim config, it will manage the entire `.vim` directory for that user, and remove unmannaged files.

### Setup Requirements

This module currently only officially supports Ubuntu, but likely will work on most other systems, particularly of a Debian flavor. If using on non-Debian based distros, it may be necessary to manually provide the vim package name. Additionally, only Git-based repos are officially supported. Others may work, but only Git has been tested.

This module additionally has the following dependencies:
* `lwf/remote_file`: used when `Vim::Plugin` is provided an http/https URL for the `source` parameter.
* `puppetlabs/git`: used to install Pathogen bundles from git (if using a Git repo)
* `puppetlabs/stdlib`: default
* `puppetlabs/vcsrepo`: used for installing/managing Pathogen bundles. Might be able to support other repo types, but only Git has been tested.

### Beginning with vim

Install the module with:

```
puppet module install brwyatt-vim
```

## Usage

### Install vim

To install vim, include the module into your manifests:

```
include ::vim
```

All `Vim` module resources are realized in `Vim::Configure`, so may be included as virtual resources in global user configs, and will only be realized on systems that also include the main `Vim` class or `Vim::Configure`.

### Managing user config

```
@vim::config { '/home/brwyatt':
  ensure => present,
  owner  => 'brwyatt',
}
```

This will manage the user's `.vimrc` and setup the user's `.vim` directory, including directories for plugins and bundles.

### Installing plugins

```
@vim::plugin { 'pathogen':
  owner    => 'brwyatt',
  autoload => true,
  source   =>
    'https://raw.githubusercontent.com/tpope/vim-pathogen/v2.4/autoload/pathogen.vim',
  vim_dir  => '/home/brwyatt/.vim',
}
```

This installs the plugin at the indicated source to the user's `.vim/plugins` directory, and adds a symlink in `.vim/autoload` to it. The file will be called `pathogen.vim` and is based on this resource's name, and can be overridden by the `plugin_name` parameter.

### Installing bundles

```
@vim::bundle { 'puppet':
  ensure   => present,
  owner    => 'brwyatt',
  repo     => 'https://github.com/voxpupuli/vim-puppet.git',
  revision => 'master',
  vim_dir  => '/home/brwyatt/.vim',
}
```

This will install the bundle from the indicated Git repository into the user's `.vim/bundle` directory as "puppet", based on the resource's name. This name can be overridden with the `bundle_name` parameter.

## Limitations

Currently, this module can only install on Debian-based systems and has not been tested on distributions other than Ubuntu 16.04 and 18.04. It may or may not work on other Debian-based distributions, but makes no claims regarding such.

## Development

Feel free to file issues in the GitHub [issue tracker](https://github.com/brwyatt/puppet-vim/issues) for the repository, or submit [Pull Requests](https://github.com/brwyatt/puppet-vim/pulls).

I may not have much time to work on (or test) this myself, so help to expand current functionality (especially to make it work for more people) is greatly appreciated and encouraged.

## Contributors

The list of contributors can be found at: [https://github.com/brwyatt/puppet-vim/graphs/contributors](https://github.com/brwyatt/puppet-vim/graphs/contributors).
