define ohmyzsh::theme(
  $theme = 'clean',
  $user = $name
) {
  if $user == 'root' {
    $home = '/root'
  } else {
    $home = "${ohmyzsh::params::home}/${user}"
  }

  if $theme == 'codeaddict' {
    file { "$home/.oh-my-zsh/custom/themes/codeaddict.zsh-theme":
      ensure => present,
      owner => $user,
      source => 'puppet:///ohmyzsh/codeaddict.zsh-theme',
    }
  }

  file_line { "${user}-${theme}-install":
    path    => "${home}/.zshrc",
    line    => "ZSH_THEME=\"${theme}\"",
    match   => '^ZSH_THEME',
    require => Ohmyzsh::Install[$user],
  }
}
