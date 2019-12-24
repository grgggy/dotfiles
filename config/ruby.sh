#!/usr/bin/env bash

# Install Ruby
echo "Installing Ruby..."
sudo rm -rf $HOME/.rbenv /usr/local/rbenv /opt/rbenv /usr/local/opt/rbenv
brew uninstall --force rbenv ruby-build
unset RBENV_ROOT && exec zsh
brew install rbenv ruby-build && exec zsh
rbenv install 2.6.3
rbenv global 2.6.3
echo "Please (⌘ + Q) this terminal then run gems.sh file."
