define ohmyzsh::alias(
  $command,
  $user,
  $home,
  $alias         = $resource_name,
  $resource_name = undef,
) {

  $aliases_file = "${home}/.zshrc.d/aliases.sh"
  if ! defined(File[$aliases_file]) {
    file { $aliases_file:
      ensure  => present,
      owner   => $user,
      require => File["${home}/.zshrc.d"],
    }
  }

  file_line { "${user}-zsh-alias-${alias}":
    path    => $aliases_file,
    line    => "alias ${alias}=\"${command}\"",
    match   => "^alias ${alias}=",
    require => [Ohmyzsh::Install[$user], File[$aliases_file]]
  }

}
