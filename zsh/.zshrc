# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"

# fnm
export PATH="/home/xexperimente/.local/share/fnm:$PATH"
eval "`fnm env`"

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

# Fast node manager
plug "wintermi/zsh-fnm"

# <Esc><Esc> to run previous command with sudo
plug "zap-zsh/sudo"

# Load and initialise completion system
autoload -Uz compinit
compinit