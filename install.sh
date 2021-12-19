#!/bin/sh

echo "Setting up your workstation..."

# Install MacOS applications
if test "$(uname)" = "Darwin"; then
  echo "--Install brew formulae on MacOS"
  ./brew.sh
  echo "--Installation of brew formulae DONE"
fi

# Symlink dotfiles
echo "--Symlink dotfiles"
ln -sf ${PWD}/.gitconfig ~/.gitconfig
ln -sf ${PWD}/.site-functions ~/.site-functions
ln -sf ${PWD}/.zshrc ~/.zshrc
ln -sf ${PWD}/.gitignore_global ~/.gitignore
echo "--Symlinking of dotfiles DONE"

