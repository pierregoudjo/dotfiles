#!/bin/sh

echo "Setting up your workstation..."

# Install MacOS applications
# if test "$(uname)" = "Darwin"; then
  echo "--Install brew formulae"
  # Check for Homebrew and install if we don't have it
  if ! type brew > /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  if test "$(uname)" = "Darwin"; then
    BREW_EXECUTABLE="/opt/homebrew/bin/brew"
  else
    BREW_EXECUTABLE="/home/linuxbrew/.linuxbrew/bin/brew"
  fi

  echo "---Create/update .zprofile file"
  (echo; echo 'eval "$(' $BREW_EXECUTABLE ' shellenv)"') > ~/.zprofile
  echo "---Create/update .zprofile file DONE"

  echo "---Load .zprofile with brew path added"
  source ~/.zprofile
  echo "---Load .zprofile with brew path added DONE"


  # Update Homebrew recipes
  echo "-----Fetch the newest version of Homebrew and all formulae"
  $BREW_EXECUTABLE update
  echo "-----Fetch the newest version of Homebrew and all formulae DONE"

  # Install all our dependencies with bundle (See Brewfile)
  echo "-----Install and upgrade all dependencies from Brewfile"
  $BREW_EXECUTABLE bundle
  echo "-----Install and upgrade all dependencies from Brewfile DONE"
  echo "--Installation of brew formulae DONE"
# fi

# if test "$(uname)" = "Linux"; then
#   echo "--Install apt-get packages on Linux"
#   ./apt-get.sh
#   echo "--Installation of apt-get package on Linux DONE"
# fi

# # Create profile to integrate with Homebrew
# if test "$(uname)" = "Darwin"; then
#   echo "---Create/update .zprofile file"
#   (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') > ~/.zprofile
# fi

# Create config directory
echo "---Create .config directory if it doesn't exist"
mkdir -pv ~/.config
echo "---Create .ssh directory if it doesn't exist"
mkdir -pv ~/.ssh
# Symlink dotfiles
echo "--Symlink dotfiles"
ln -svf ${PWD}/.gitconfig ~/.gitconfig
ln -svf ${PWD}/.zshrc ~/.zshrc
ln -svf ${PWD}/.gitignore_global ~/
ln -svf ${PWD}/.gitignore_global ~/
ln -svf ${PWD}/starship/starship.toml ~/.config/
ln -svf ${PWD}/.site-functions ~/
ln -svf ${PWD}/gh/ ~/.config/
ln -svf ${PWD}/ghostty ~/.config/
ln -svf ${PWD}/zellij ~/.config/
ln -svf ${PWD}/.terraformrc ~/
ln -svf ${PWD}/bin ~/
ln -svf ${PWD}/.ssh/config ~/.ssh/
ln -svf ${PWD}/eza ~/.config/
ln -svf ${PWD}/bat/ ~/.config/
ln -svf ${PWD}/nvim/ ~/.config/
ln -svf ${PWD}/aerc/ ~/.config/
ln -svf ${PWD}/lazygit/ ~/.config/
ln -svf ${PWD}/vdirsyncer/ ~/.config/
ln -svf ${PWD}/khard/ ~/.config/
ln -svf ${PWD}/khal/ ~/.config/

if test "$(uname)" = "Darwin"; then
  mkdir -pv ~/Library/Application\ Support/Sublime\ Text/Packages/
  ln -sf ${PWD}/sublimetext/User ~/Library/Application\ Support/Sublime\ Text/Packages/
fi

echo "--Symlinking of dotfiles DONE"

# Create some required directories
echo "--Bootstraping some required directories"
mkdir -pv ~/.terraform.d/plugin-cache
echo "--Bootstraping some required directories DONE"

