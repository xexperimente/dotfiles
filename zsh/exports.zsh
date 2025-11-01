#!/bin/sh
HISTSIZE=1000000
SAVEHIST=1000000

export PATH="$HOME/.local/bin:$HOME/.local/share/bob/nvim-bin:$HOME/.local/share/nvim/mason/bin:$PATH"

export STARSHIP_CONFIG="$HOME/.config/starship.toml"

export EDITOR="nvim"
export SYSTEMD_EDITOR="nvim"

export MANPAGER="nvim +Man!"
