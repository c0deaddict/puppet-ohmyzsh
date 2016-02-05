define ohmyzsh::warp(
  $ensure         = present,
  $alias          = $resource_name,
  $target,
  $user,
  $home,
  $resource_name  = undef,
) {

  $warprc = "${home}/.warprc"
  if ! defined(File[$warprc]) {
    file { $warprc:
      ensure => present,
      owner  => $user,
    }
  }

  file_line { "${user}-zsh-warp-${target}":
    ensure  => $ensure,
    path    => $warprc,
    line    => "${alias}:${target}",
    match   => "^${alias}\:",
    require => File[$warprc],
  }

}
