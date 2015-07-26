define ohmyzsh::alias(
  $command,
  $user,
  $alias = $name
) {
  if $user == 'root' { $home = '/root' } else { $home = "${ohmyzsh::params::home}/${user}" }
  
  file_line { "$home/.zshrc.d/aliases":
    path => "$home/.zshrc.d/aliases",
    line => "alias $alias='$command'",
    match => "^alias $alias=",
    require => Ohmyzsh::Install[$user],
  }
}
