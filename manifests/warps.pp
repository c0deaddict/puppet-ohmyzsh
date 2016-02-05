define ohmyzsh::warps(
  $user = $name,
  $home,
  $map  = {},
) {

  $map.each |$alias, $target| {
    create_resources('ohmyzsh::warp', {
      "${user}-${alias}" => {
        alias   => $alias,
        target  => $target,
        user    => $user,
        home    => $home,
        require => Ohmyzsh::Install[$user],
      }
    })
  }

}
