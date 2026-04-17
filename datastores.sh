#!/usr/bin/env bash

# Install data stores using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew if not present.
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Add Homebrew to PATH for the rest of this script (Apple Silicon + Intel).
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

brew update

# Install data stores
brew install mysql
brew install postgresql
brew tap mongodb/brew && brew install mongodb-community
brew install redis
brew install elasticsearch

# GUI tools
brew install --cask mysqlworkbench
brew install --cask graphiql

# Remove outdated versions from the cellar.
brew cleanup
