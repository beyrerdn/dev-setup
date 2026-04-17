#!/usr/bin/env bash

# Install command-line tools and apps using Homebrew + Brewfile.

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

# Make sure we're using the latest Homebrew and formulae.
brew update
brew upgrade

# Install everything from the Brewfile.
brew bundle --file="$(dirname "$0")/Brewfile"

# Switch to zsh (macOS default since Catalina).
if [[ "$SHELL" != "/bin/zsh" ]]; then
  echo "Switching login shell to zsh..."
  chsh -s /bin/zsh
fi

# Remove outdated versions from the cellar.
brew cleanup

echo "Done! Open a new terminal window to start using your new setup."
