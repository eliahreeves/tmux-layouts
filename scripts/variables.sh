#!/usr/bin/env bash

CONFIG_DIR=$(tmux show-option -gqv "@sessions-config-path")
CONFIG_DIR="${CONFIG:-"$HOME/.tmux/sessions/"}"
if [[ ${CONFIG_DIR} == ~* ]]; then
	CONFIG_DIR="${CONFIG_DIR/\~/$HOME}"
fi
mkdir -p "$CONFIG_DIR"
