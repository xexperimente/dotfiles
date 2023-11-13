#!/bin/sh
HISTSIZE=1000000
SAVEHIST=1000000

export EDITOR="nvim"
export PATH="$HOME/.local/bin":$PATH
export STARSHIP_CONFIG="$HOME/.config/starship.toml"

