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
ln -shF ${PWD}/.site-functions/ ~/.site-functions
ln -sf ${PWD}/.zshrc ~/.zshrc
ln -sf ${PWD}/.gitignore_global ~/.gitignore
echo "--Symlinking of dotfiles DONE"

