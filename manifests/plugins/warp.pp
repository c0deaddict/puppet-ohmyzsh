define ohmyzsh::plugins::warp(
    $dir,
    $user,
    $ensure = 'present',
) {
  if $user == 'root' {
    $home = '/root'
  } else {
    $home = "${ohmyzsh::params::home}/${user}"
  }
  
  if !defined(File["$home/.warprc"]) {
    file { "$home/.warprc":
      ensure => present,
      owner => $user,
    }
  }

  file_line { "$user zsh warp $name":
    path => "$home/.warprc",
    line => "$name:$dir",
    match => "^${name}:",
    ensure => $ensure,
    require => File["$home/.warprc"],
  }
}
