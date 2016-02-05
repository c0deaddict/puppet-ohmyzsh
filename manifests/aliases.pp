define ohmyzsh::aliases(
  $user = $name,
  $home,
  $map  = {},
) {

  $map.each |$alias, $command| {
    create_resources('ohmyzsh::alias', {
      "${user}-${alias}": {
        alias   => $alias,
        command => $command,
        user    => $user,
        home    => $home,
      })
    }
  }

}
