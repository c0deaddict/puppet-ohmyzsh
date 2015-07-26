define ohmyzsh::plugins::wd(
    $alias,
    $dir,
    $ensure = 'present'
) {
    file_line { "zsh-wd-$home-$alias-$dir":
        path => "$home/.warprc",
        line => "$alias:$dir",
        match => "^$alias\:",
        ensure => $ensure,
    }
}
