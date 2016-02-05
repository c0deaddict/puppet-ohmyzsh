define ohmyzsh::alias(
  $command,
  $user,
  $home,
  $resource_name,
) {

  $aliases_file = "${home}/.zshrc.d/aliases.sh"
  if ! defined(File[$aliases_file]) {
    file { $aliases_file:
      ensure  => present,
      owner   => $user,
      require => File["${home}/.zshrc.d"],
    }
  }

  file_line { "${user}-zsh-alias-${resource_name}":
    path    => $aliases_file,
    line    => "alias ${resource_name}=\"${command}\"",
    match   => "^alias ${resource_name}=",
    require => [Ohmyzsh::Install[$user], File[$aliases_file]]
  }

}
