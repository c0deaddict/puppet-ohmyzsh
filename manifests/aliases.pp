define ohmyzsh::aliases(
  $user = $name,
  $home,
  $map  = {},
) {

  $map.each |$real_alias, $command| {
    create_resources('ohmyzsh::alias', {
      "${user}-${real_alias}" => {
        resource_name => $real_alias,
        command       => $command,
        user          => $user,
        home          => $home,
      }
    })
  }

}
