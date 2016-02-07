define ohmyzsh::theme(
  $ensure  = file,
  $source  = undef,
  $content = undef,
  $user,
  $home,
  $resource_name,
) {

  file { "$home/.oh-my-zsh/custom/themes/${resource_name}.zsh-theme":
    ensure  => $ensure,
    owner   => $user,
    source  => $source,
    content => $content,
    require => Ohmyzsh::Install[$user],
  }

}
