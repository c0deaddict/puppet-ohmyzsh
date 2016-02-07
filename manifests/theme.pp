define ohmyzsh::theme(
  $ensure  = present,
  $theme   = $name,
  $source  = undef,
  $content = undef,
  $user,
  $home,
) {

  file { "$home/.oh-my-zsh/custom/themes/$theme.zsh-theme":
    ensure  => $ensure,
    owner   => $user,
    source  => $source,
    content => $content,
    require => Ohmyzsh::Install[$user],
  }

}
