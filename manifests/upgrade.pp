# == Class: ohmyzsh::upgrade
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
#
# === Copyright
#
# Copyright 2013 Leon Brocard
#
define ohmyzsh::upgrade(
  $user = $name,
  $home,
) {

  exec { "ohmyzsh-git-upgrade-$user":
    command => '/usr/bin/git pull --rebase --stat origin master',
    cwd     => "$home/.oh-my-zsh",
    user    => $user,
    require => Ohmyzsh::Install[$user],
  }
}
