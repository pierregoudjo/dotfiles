#!/bin/sh

echo "-----Setting up your workstation..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
# Update Homebrew recipes
echo "-----Fetch the newest version of Homebrew and all formulae"
brew update

# Install all our dependencies with bundle (See Brewfile)
echo "-----Install and upgrade all dependencies from Brewfile"
brew tap homebrew/bundle
brew bundle

# Make ZSH the default shell environment
echo "-----Check ZSH"
if test ! $(echo $SHELL|grep zsh); then
  echo "Make ZSH the default shell environment"
  chsh -s $(which zsh)
else
  echo "ZSH is the default shell"
fi

