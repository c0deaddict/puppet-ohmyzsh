define zsh (
    $user = 'jos',
    $home = "${zsh::params::home}/$user",
    $theme = 'codeaddict',
    $aliases = []
) {

    ohmyzsh::install { $user: }

    file { "$home/.oh-my-zsh/custom/themes/codeaddict.zsh-theme":
        content => source('from repo')
    }

    ohmyzsh::theme { $user:
        theme => $theme
    }
    
    ohmyzsh::plugins { 'git git-flow wd docker sudo': }

    file { "$home/.zshrc.d":
        owner => $user,
        group => $user,
        mode => 0755,
        ensure => directory,
    }

    file_line { "$user-source-zshrc.d":
        path => "$home/.zshrc",
        line => "source ~/.zshrc.d",
        require => File["$home/.zshrc.d"],
    }

    file { "$home/.zshrc.d/aliases":
        owner => $user,
        ensure => file,
        content => template('zsh/aliases.erb'),
        require => File["$home/.zshrc.d"],
    }
}
