#!/usr/bin/env bash

if(! (command -v fish &> /dev/null)); then
  echo "Installing fish shell ..."
  pamac install fish
fi

# Install oh-my-fish if needed
# We need to use `fish` in order to detect if `omf` is installed
omf_check=$(fish -c "test (omf version) ; and echo 0; or echo 1")

if [[ "$omf_check" -ne "0" ]]; then
  echo "Installing oh-my-fish ..."
  curl -L https://get.oh-my.fish | fish
fi

# link oh-my-fish config
[ ! -L ~/.config/omf ] && {
  mv ~/.config/omf ~/.dotfiles/.backup/ &> /dev/null
  ln -sf ~/.dotfiles/omf ~/.config
}

# Install om-my-fish packages
fish -c "omf install"

PATH_TO_FISH_BIN=$(command -v fish)

# Add fish to allowed shells
(echo $PATH_TO_FISH_BIN | sudo tee -a /etc/shells) &> /dev/null

# Set fish as the default shell
sudo chsh -s $PATH_TO_FISH_BIN $(whoami) 
