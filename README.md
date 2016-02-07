# c0deaddict-ohmyzsh Puppet Module

This is the [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) module. It is a fork of [the oh-my-zsh module by acme](https://github.com/acme/puppet-acme-oh-my-zsh). It installs oh-my-zsh for a one or more users and changes their shell to zsh. It also can configure themes, plugins, aliases and warps for users.

oh-my-zsh is a community-driven framework for managing your zsh configuration. See [https://github.com/robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) for more details.

This module is called ohmyzsh as Puppet does not support hyphens in module names.

## Installation

### From Puppet Forge

```bash
  $ puppet module install c0deaddict/ohmyzsh
```

### From source

```bash
  $ cd PUPPET_MODULEDIR
  $ git clone https://github.com/c0deaddict/puppet-ohmyzsh ohmyzsh
```

## Usage

```
ohmyzsh::install { 'jos':
  home    => '/home/jos',
  theme   => 'clean',
  plugins => ['wd', 'git', 'docker'],
  env     => {
    'EDITOR' => 'vim',
  },
  aliases => {
    'dc' => 'docker-compose',
  },
  warps   => {
    'p'  => '~/Projects',
  }
}
```

License
-------

Apache License, Version 2.0.


Contact
-------

Leon Brocard acme@astray.com
Jos van Bakel jos@codeaddict.org

Support
-------

Please log tickets and issues at [GitHub](https://github.com/c0deaddict/puppet-ohmyzsh)
