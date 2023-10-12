#!/bin/sh

echo "Setting up your workstation..."

# Install MacOS applications
if test "$(uname)" = "Darwin"; then
  echo "--Install brew formulae on MacOS"
  ./brew.sh
  echo "--Installation of brew formulae DONE"
fi

if test "$(uname)" = "Linux"; then
  echo "--Install apt-get packages on Linux"
  ./apt-get.sh
  echo "--Installation of apt-get package on Linux DONE"
fi

# Create profile to integrate with Homebrew
if test "$(uname)" = "Darwin"; then
  echo "---Create/update .zprofile file"
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') > ~/.zprofile
fi

# Create config directory
echo "---Create .config directory if it doesn't exist"
mkdir -p ~/.config
# Symlink dotfiles
echo "--Symlink dotfiles"
ln -shF ${PWD}/.gitconfig ~/.gitconfig
ln -shF ${PWD}/.zshrc ~/.zshrc
ln -shF ${PWD}/.gitignore_global ~/.gitignore
ln -shF ${PWD}/.gitignore_global ~/.gitignore
ln -shF ${PWD}/starship/starship.toml ~/.config/starship.toml
ln -shF ${PWD}/.site-functions/ ~/.site-functions
ln -shF ${PWD}/gh/ ~/.config/gh
ln -shF ${PWD}/alacritty ~/.config/alacritty
ln -shF ${PWD}/zellij ~/.config/zellij
ln -shF ${PWD}/.terraformrc ~/.terraformrc
ln -shF ${PWD}/bin ~/bin

if test "$(uname)" = "Darwin"; then
  mkdir -p ~/Library/Application\ Support/Sublime\ Text/Packages/
  ln -sf ${PWD}/sublimetext/User ~/Library/Application\ Support/Sublime\ Text/Packages/
fi

echo "--Symlinking of dotfiles DONE"

# Create some required directories
echo "--Bootstraping some required directories"
mkdir -p ~/.terraform.d/plugin-cache
echo "--Bootstraping some required directories DONE"

