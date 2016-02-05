define ohmyzsh::theme(
  $theme = 'clean',
  $user  = $name,
  $home,
) {
  if $theme == 'codeaddict' {
    file { "$home/.oh-my-zsh/custom/themes":
      ensure => directory,
      owner  => $user,
    } ->
    file { "$home/.oh-my-zsh/custom/themes/codeaddict.zsh-theme":
      ensure  => present,
      owner   => $user,
      source  => 'puppet:///modules/ohmyzsh/codeaddict.zsh-theme',
    }
  }

  file_line { "${user}-${theme}-install":
    path    => "${home}/.zshrc",
    line    => "ZSH_THEME=\"${theme}\"",
    match   => '^ZSH_THEME',
    require => Ohmyzsh::Install[$user],
  }
}
