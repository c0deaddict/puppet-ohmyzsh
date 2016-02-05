# == Class: ohmyzsh::install
#
# This is the ohmyzsh module. It installs oh-my-zsh for a user and changes
# their shell to zsh. It has been tested under Ubuntu.
#
# This module is called ohmyzsh as Puppet does not support hyphens in module
# names.
#
# oh-my-zsh is a community-driven framework for managing your zsh configuration.
#
# === Parameters
#
# None.
#
# === Examples
#
# class { 'ohmyzsh': }
# ohmyzsh::install { 'acme': }
#
# === Authors
#
# Leon Brocard <acme@astray.com>
# Jos van Bakel <josvanbakel@gmail.com>
#
# === Copyright
#
# Copyright 2013 Leon Brocard
# Copyright 2015 Jos van Bakel
#
define ohmyzsh::install(
  $user = $name,
  $home,
) {

  notify { "ohmyzsh::install is being installed on $user": }

  include ohmyzsh

  exec { "ohmyzsh::git clone ${user}":
    creates => "${home}/.oh-my-zsh",
    command => "/usr/bin/git clone git://github.com/robbyrussell/oh-my-zsh.git ${home}/.oh-my-zsh",
    user    => $user,
    require => [Package['git'], Package['zsh']]
  } ->
  exec { "ohmyzsh::cp .zshrc ${user}":
    creates => "${home}/.zshrc",
    command => "/bin/cp ${home}/.oh-my-zsh/templates/zshrc.zsh-template ${home}/.zshrc",
    user    => $user,
  }

  if ! defined(User[$user]) {
    user { "ohmyzsh::user ${user}":
      ensure     => present,
      name       => $user,
      managehome => true,
      shell      => $ohmyzsh::params::zsh,
      require    => Package['zsh'],
    }
  } else {
    User <| title == $user |> {
      shell => $ohmyzsh::params::zsh
    }
  }

  file { "$home/.zshrc.d":
    owner  => $user,
    group  => $user,
    mode   => '0755',
    ensure => directory,
  } ->
  file_line { "${user}-source-zshrc.d":
    path    => "$home/.zshrc",
    line    => "source ~/.zshrc.d/*",
  }
}
