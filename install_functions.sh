function install_oh_my_zsh {
    echo "Installing oh-my-zsh"
    [ ! -d "$HOME/.oh-my-zsh" ] &&
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    echo "Installing powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
    
    echo "Installing required fonts"
    if [ "$1" = "linux" ] ; then
        mkdir -p $HOME/.local/share/fonts

        cd $HOME/.local/share/fonts &&
        curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf 
        sudo chsh -s /usr/bin/zsh root
        
        cd $HOME/dotfiles
    elif [ "$1" = "mac"] ; then
        brew tap homebrew/cask-fonts
        brew cask install font-hack-nerd-font
    fi

    echo "Installing zsh plugins"
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
}

function install_anaconda {
    echo "Installing anaconda"
    if ! command -v conda >/dev/null 2>&1 ; then
        wget https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O anaconda.sh &&
        bash anaconda.sh -b -p $HOME/anaconda &&
        rm anaconda.sh &&
        export PATH=$HOME/anaconda/bin:$PATH
    else
        echo "anaconda already installed"
    fi
    conda init zsh
    # Install jupyter lab
    conda install --yes jupyterlab ipykernel

    # jupyter notebook --generate-config
}
