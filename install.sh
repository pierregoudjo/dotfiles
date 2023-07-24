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

# Symlink dotfiles
echo "--Symlink dotfiles"
ln -sf ${PWD}/.gitconfig ~/.gitconfig
ln -sf ${PWD}/.zshrc ~/.zshrc
ln -sf ${PWD}/.gitignore_global ~/.gitignore
ln -sf ${PWD}/.gitignore_global ~/.gitignore
ln -sf ${PWD}/starship/starship.toml ~/.config/starship.toml
ln -shF ${PWD}/.site-functions/ ~/.site-functions
ln -shF ${PWD}/gh/ ~/.config/gh
ln -shF ${PWD}/alacritty ~/.config/alacritty
ln -shF ${PWD}/zellij ~/.config/zellij
ln -sf ${PWD}/.terraformrc ~/.terraformrc

echo "--Symlinking of dotfiles DONE"

# Create some required directories
echo "--Bootstraping some required directories"
mkdir -p ~/.terraform.d/plugin-cache
echo "--Bootstraping some required directories DONE"
