# Initialize Homebrew (works on both Apple Silicon and Intel)
eval "$(brew shellenv)"

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Initialize rbenv
if command -v rbenv &>/dev/null; then
    eval "$(rbenv init - zsh)"
fi
