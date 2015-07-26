define ohmyzsh::plugins::warps($warps) {
  create_resources('ohmyzsh::plugins::warp', $warps, {
    user => $name,
  })
}
