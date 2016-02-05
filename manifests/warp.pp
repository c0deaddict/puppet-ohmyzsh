define ohmyzsh::warp(
  $ensure         = present,
  $target,
  $user,
  $home,
  $resource_name,
) {

  $warprc = "${home}/.warprc"
  if ! defined(File[$warprc]) {
    file { $warprc:
      ensure => present,
      owner  => $user,
    }
  }

  $expanded_target = regsubst($target, '^~', $home)
  file_line { "${user}-zsh-warp-${resource_name}":
    ensure  => $ensure,
    path    => $warprc,
    line    => "${resource_name}:${expanded_target}",
    match   => "^${resource_name}\\:",
    require => File[$warprc],
  }

}
