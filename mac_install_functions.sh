function install_homebrew {

    brew_packages=(
        "node"
        "bash"
        "iterm2"        
        "git"                 
        "gcc"                 
        "tmux"                
        "wget"                
        "tree"                
        "exa"                 
        "heroku-cli"          
        "heroku/brew/heroku"  
        "zsh"                 
        "diff-so-fancy"       
        "bat"			
)

    command -v brew >/dev/null 2>&1 ||
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 
    
    # Install homebrew packages that might not already be installed.
    echo -e "\nInstalling packages from regular brew"
    for pkg in "${BREW_PACKAGES[@]}"; do
      if ! brew list -1 | grep -q "^${pkg}\$";
      then
        echo "Installing $pkg"
        brew install "$pkg"
      fi
    done
}
