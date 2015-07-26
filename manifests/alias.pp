define ohmyzsh::alias(
  $key,
  $command,
  $user = $name
) {
  if $user == 'root' {
    $home = '/root'
  } else {
    $home = "${ohmyzsh::params::home}/${user}"
  }
  
  file_line { "$home/.zshrc.d/aliases":
    path => "$home/.zshrc.d/aliases",
    line => "alias $key='$command'",
    match => "^alias $key=",
    require => [Ohmyzsh::Install[$user], File["$home/.zshrc.d"]]
  }
}
