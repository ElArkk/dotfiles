function install_packages {

    PACKAGES=(
        "build-essential"
        "curl"
        "nodejs"
        "bash"
        "git"
        "tmux"
        "wget"
        "tree"
        "zsh"
        "diff-so-fancy"
        "bat"
    )

    
    echo "Installing packages using apt"
    for pkg in "${PACKAGES[@]}"; do
      if ! apt list | grep "^${pkg}\$";
      then
        echo "Installing $pkg"
        sudo apt install "$pkg"
      fi
    done

    echo "Installing exa"
    command -v exa >/dev/null 2>&1 ||
    curl https://sh.rustup.rs -sSf | sh &&
    wget -c https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip &&
    unzip exa-linux-x86_64-0.8.0.zip &&
    sudo mv exa-linux-x86_64 /usr/local/bin/exa
    
    echo "Installing heroku-cli"
    command -v exa >/dev/null 2>&1 ||
    curl https://cli-assets.heroku.com/install.sh | sh

    echo "Installing diff-so-fancy"
    git clone https://github.com/so-fancy/diff-so-fancy.git $HOME/bin/diff-so-fancy
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
    git config --global color.ui true

    git config --global color.diff-highlight.oldNormal    "red bold"
    git config --global color.diff-highlight.oldHighlight "red bold 52"
    git config --global color.diff-highlight.newNormal    "green bold"
    git config --global color.diff-highlight.newHighlight "green bold 22"

    git config --global color.diff.meta       "11"
    git config --global color.diff.frag       "magenta bold"
    git config --global color.diff.commit     "yellow bold"
    git config --global color.diff.old        "red bold"
    git config --global color.diff.new        "green bold"
    git config --global color.diff.whitespace "red reverse"

}

function install_conky {
    echo "Installing conky. Replace network interface name in .conkyrc after installation."
    echo "Network interface name:"
    ip -o -4 route show to default | awk '{print $5}'
    command -v conky >/dev/null 2>&1 || sudo apt -y install conky-all
    python3 set_startupscript.py 'Conky' '/usr/bin/conky'
}

function install_espanso {
    wget https://github.com/federico-terzi/espanso/releases/latest/download/espanso-debian-amd64.deb
    sudo apt install ./espanso-debian-amd64.deb
    rm espanso-debian-amd64.deb
    espanso start
    cp -r espanso/user/. $HOME/.config/espanso/user
}
