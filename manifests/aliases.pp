define ohmyzsh::aliases($aliases) {
  create_resources('ohmyzsh::alias', $aliases, {
    user => $name,
  })
}
