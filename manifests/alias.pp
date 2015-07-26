define ohmyzsh::alias(
  $command,
  $user
) {
  if $user == 'root' {
    $home = '/root'
  } else {
    $home = "${ohmyzsh::params::home}/${user}"
  }

  if not defined(File["$home/.zshrc.d/aliases"]) {
    file { "$home/.zshrc.d/aliases":
      ensure => present,
      owner => $user,
      require => File["$home/.zshrc.d"],
    }
  }
  
  file_line { "$user ohmyzsh alias $name":
    path => "$home/.zshrc.d/aliases",
    line => "alias $name='$command'",
    match => "^alias $name=",
    require => [Ohmyzsh::Install[$user], File["$home/.zshrc.d/aliases"]]
  }
}
