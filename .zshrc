# Load shared dotfiles: aliases, functions, exports, and local extras
for file in ~/.{exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# zsh options
setopt AUTO_CD           # cd by typing directory name
setopt HIST_APPEND       # append to history instead of overwriting
setopt SHARE_HISTORY     # share history across sessions
setopt HIST_IGNORE_DUPS  # don't record duplicate commands
setopt NOCASEGLOB        # case-insensitive globbing
setopt CORRECT           # autocorrect typos in commands

# History
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE

# zsh completions
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh-completions:$(brew --prefix)/share/zsh/site-functions:$FPATH"
fi
autoload -Uz compinit && compinit

# Enable tab completion for `g` as an alias for `git`
if type _git &>/dev/null; then
    compdef g=git
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config
if [ -e "$HOME/.ssh/config" ]; then
    h=(${(f)"$(grep '^Host' ~/.ssh/config | grep -v '[?*]' | awk '{print $2}')"})
    zstyle ':completion:*:ssh:*' hosts $h
    zstyle ':completion:*:scp:*' hosts $h
fi

# Starship prompt
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi
