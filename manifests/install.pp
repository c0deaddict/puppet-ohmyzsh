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
# Jos van Bakel <jos@codeaddict.org>
#
# === Copyright
#
# Copyright 2013 Leon Brocard
# Copyright 2015 Jos van Bakel
#
define ohmyzsh::install(
  $home,
  $theme,
  $user                = $name,
  $plugins             = ['git'],
  $env                 = {},
  $opts                = {},
  $aliases             = {},
  $warps               = {},
  $git_repo            = $ohmyzsh::git_repo,
  $update_zsh_days     = $ohmyzsh::update_zsh_days,
  $hist_stamps         = $ohmyzsh::hist_stamps,
  $case_sensitive      = $ohmyzsh::case_sensitive,
  $disable_auto_update = $ohmyzsh::disable_auto_update,
) {

  notify { "ohmyzsh::install is being installed on $user": }

  include ohmyzsh

  if ! defined(User[$user]) {
    fail("User $user is not defined")
  }

  User <| title == $user |> {
    shell => $ohmyzsh::zsh_bin
  }

  exec { "ohmyzsh-git-clone-$user":
    creates => "$home/.oh-my-zsh",
    command => "/usr/bin/git clone $git_repo $home/.oh-my-zsh",
    user    => $user,
    require => Class['ohmyzsh'],
  } ->
  file { "$home/.oh-my-zsh/custom/themes":
    ensure => directory,
    owner  => $user,
  }

  file { "$home/.zshrc.d":
    owner  => $user,
    group  => $user,
    mode   => '0755',
    ensure => directory,
  }

  $plugins_joined = join($plugins, ' ')

  file { "$home/.zshrc":
    ensure  => file,
    owner   => $user,
    group   => $user,
    mode    => '0644',
    content => template('ohmyzsh/zshrc.erb'),
  }

  $aliases.each |$short, $command| {
    create_resources('ohmyzsh::alias', {
      "${user}-${short}" => {
        resource_name => $short,
        command       => $command,
        user          => $user,
        home          => $home,
      }
    })
  }

  $warps.each |$short, $target| {
    create_resources('ohmyzsh::warp', {
      "${user}-${short}" => {
        resource_name => $short,
        target        => $target,
        user          => $user,
        home          => $home,
      }
    })
  }

}
