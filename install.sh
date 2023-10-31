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
mkdir -pv ~/.config
echo "---Create .ssh directory if it doesn't exist"
mkdir -pv ~/.ssh
# Symlink dotfiles
echo "--Symlink dotfiles"
ln -shFv ${PWD}/.gitconfig ~/.gitconfig
ln -shFv ${PWD}/.zshrc ~/.zshrc
ln -shFv ${PWD}/.gitignore_global ~/.gitignore
ln -shFv ${PWD}/.gitignore_global ~/.gitignore
ln -shFv ${PWD}/starship/starship.toml ~/.config/starship.toml
ln -shFv ${PWD}/.site-functions/ ~/.site-functions
ln -shFv ${PWD}/gh/ ~/.config/gh
ln -shFv ${PWD}/alacritty ~/.config/alacritty
ln -shFv ${PWD}/zellij ~/.config/zellij
ln -shFv ${PWD}/.terraformrc ~/.terraformrc
ln -shFv ${PWD}/bin ~/bin
ln -shFv ${PWD}/.ssh/config ~/.ssh/config

if test "$(uname)" = "Darwin"; then
  mkdir -pv ~/Library/Application\ Support/Sublime\ Text/Packages/
  ln -sf ${PWD}/sublimetext/User ~/Library/Application\ Support/Sublime\ Text/Packages/
fi

echo "--Symlinking of dotfiles DONE"

# Create some required directories
echo "--Bootstraping some required directories"
mkdir -pv ~/.terraform.d/plugin-cache
echo "--Bootstraping some required directories DONE"

