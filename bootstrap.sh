#!/bin/sh

echo "Bootstrapping your Mac..."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

if [ ! -e "/usr/local/bin/brew" ]; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Updating Homebrew..."
brew update

echo "Installing applications...Please make sure you have signed in to Mac App Store"
brew tap homebrew/bundle
brew bundle
brew cleanup

echo "Creating symbolic links for dotfiles..."
dotfiles=(
  ".ackrc"
  ".gitconfig"
  ".vimrc"
  ".zshrc"
)
for f in "${dotfiles[@]}"
do
  rm -rf $HOME/$f
  ln -s $HOME/Dotfiles/$f $HOME/$f
done

echo "Setting up macOS preferences..."
source $HOME/Dotfiles/.macos

echo "Setting up default web browser..."
defaultbrowser chrome
