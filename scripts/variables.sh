#!/usr/bin/env bash

CONFIG_DIR=$(tmux show-option -gqv "@layouts-config-path")
CONFIG_DIR="${CONFIG:-"$HOME/.tmux/layouts/"}"
if [[ ${CONFIG_DIR} == ~* ]]; then
	CONFIG_DIR="${CONFIG_DIR/\~/$HOME}"
fi
mkdir -p "$CONFIG_DIR"
