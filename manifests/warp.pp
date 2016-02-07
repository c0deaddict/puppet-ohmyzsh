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

  $expanded_target = regsubst($target, '^~', $home)
  file_line { "$user-zsh-warp-$alias":
    ensure  => $ensure,
    path    => $warprc,
    line    => "${alias}:${expanded_target}",
    match   => "^${alias}\:",
    require => File[$warprc],
  }

}
