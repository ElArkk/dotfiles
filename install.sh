# Check the platform
case "$OSTYPE" in
  solaris*) echo "SOLARIS" ;;
  darwin*)  echo "OSX" ;;
  linux*)   echo "LINUX" ;;
  bsd*)     echo "BSD" ;;
  *)        echo "unknown: $OSTYPE" ;;
esac

[ ! -d "$HOME/bin" ] && mkdir $HOME/bin

[ ! -d "$HOME/.ssh" ] && mkdir $HOME/.ssh

source install_functions.sh

case "$OSTYPE" in
    darwin*)
        source mac_install_functions.sh
    
        echo "Installing xcode-select."
        xcode-select --install
        
        echo "Installing homebrew and default brew pkgs."
        install_homebrew

        echo "Customizing zsh"
        install_oh_my_zsh "mac"
        
        echo "Installing anaconda and some default python pckgs."
        install_anaconda

        echo "Enabling iTerm2 zsh shell integration"
        curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash
    ;;

    linux*)
        source linux_install_functions.sh

        echo "Installing custom packages"
        install_packages
       
        echo "Customizing zsh."
        install_oh_my_zsh "linux"

        echo "Installing anaconda and some default python pckgs."
        install_anaconda

        echo "Installing conky."
        install_conky

        echo "Creating .conkyrc symlink"
        ln -svf "$HOME/dotfiles/.conkyrc" "$HOME/.conkyrc"
    ;;

esac

echo "Creating .zshrc symlink"
ln -svf "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
echo "Creating .vimrc symlink"
ln -svf "$HOME/dotfiles/.vimrc" "$HOME/.vimrc"
