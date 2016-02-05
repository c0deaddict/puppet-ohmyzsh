define ohmyzsh::warps(
  $user = $name,
  $home,
  $map  = {},
) {

  $map.each |$warp, $target| {
    create_resources('ohmyzsh::warp', {
      "${user}-${warp}" => {
        resource_name => $warp,
        target        => $target,
        user          => $user,
        home          => $home,
        require       => Ohmyzsh::Install[$user],
      }
    })
  }

}
