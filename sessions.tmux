#!/usr/bin/env bash
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

KEY=$(tmux show-option -gqv "@sessions-finder-key")
KEY="${KEY:-f}"

tmux unbind-key "$KEY"

version_str=$(tmux -V)
version_num=$(echo "$version_str" | awk '{print $2}' | sed 's/[^0-9.].*//')
major=${version_num%%.*}
minor=${version_num#*.}
minor=${minor%%.*}

if ((major > 3)) || { ((major == 3)) && ((minor >= 2)); }; then
	tmux bind-key -r "$KEY" display-popup -E "$CURRENT_DIR/scripts/launch.sh"
else
	tmux bind-key -r "$KEY" neww "$CURRENT_DIR/scripts/launch.sh"
fi
