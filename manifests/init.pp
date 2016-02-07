# == Class: ohmyzsh
#
# This is the ohmyzsh module. It installs oh-my-zsh for a user and changes
# its shell to zsh.
#
# This module is called ohmyzsh as Puppet does not support hyphens in module
# names.
#
# oh-my-zsh is a community-driven framework for managing your zsh configuration.
#
# === Parameters
#
# [*zsh*]
#   define path to zsh binary
#
# [*home*]
#   define root path of users homedirectory, default is /home.
#
#
# === Examples
#
# class { 'ohmyzsh': }
# ohmyzsh::install { 'acme': }
# ohmyzsh::theme { 'acme': theme => 'clean' }
# ohmyzsh::plugins { 'acme': plugins => 'git github' }
#
# === Authors
#
# Leon Brocard <acme@astray.com>
#
# === Copyright
#
# Copyright 2013 Leon Brocard
#
class ohmyzsh(
  $zsh_bin             = $ohmyzsh::params::zsh,
  $git_repo            = $ohmyzsh::params::git_repo,
  $update_zsh_days     = $ohmyzsh::params::update_zsh_days,
  $hist_stamps         = $ohmyzsh::params::hist_stamps,
  $case_sensitive      = $ohmyzsh::params::case_sensitive,
  $disable_auto_update = $ohmyzsh::params::disable_auto_update,
) inherits ohmyzsh::params {

  if ! defined(Package['git']) {
    package { 'git':
      ensure => present,
    }
  }

  if ! defined(Package['zsh']) {
    package { 'zsh':
      ensure => present,
    }
  }

}
