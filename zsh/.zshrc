# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/binds.zsh"

# ZSH Auto suggest
plug "zsh-users/zsh-autosuggestions"

# Useful zsh utilities
plug "zap-zsh/supercharge"

# Highlighting for zsh
plug "zsh-users/zsh-syntax-highlighting"

# starship.rs prompt
plug "wintermi/zsh-starship"

# Better ls
plug "zap-zsh/exa"

# <Esc><Esc> to run previous command with sudo
plug "zap-zsh/sudo"

# A Zsh plugin that starts ssh-agent automatically
plug "sdiebolt/zsh-ssh-agent"

# Use system clipboard for ZLE operations
plug "kutsan/zsh-system-clipboard"

# Load and initialise completion system
autoload -Uz compinit
compinit

eval "$(zoxide init zsh)"
