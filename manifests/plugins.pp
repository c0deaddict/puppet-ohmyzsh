define ohmyzsh::plugins(
  $user    = $name,
  $home,
  $plugins = ['git'],
) {

  $plugins_line = join($plugins, ' ')
  file_line { "${user}-plugins":
    path    => "${home}/.zshrc",
    line    => "plugins=(${plugins_line})",
    match   => '^plugins=',
    require => Ohmyzsh::Install[$user],
  }

}
