#!/usr/bin/env bash
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

KEY=$(tmux show-option -gqv "@layouts-finder-key")
KEY="${KEY:-f}"

tmux unbind-key "$KEY"

# tmux hands these commands to sh -c, so escape the paths to survive spaces
LAUNCH=$(printf '%q' "$CURRENT_DIR/scripts/launch.sh")
NEW_LAYOUT=$(printf '%q' "$CURRENT_DIR/scripts/new-layout.sh")

version_str=$(tmux -V)
version_num=$(echo "$version_str" | awk '{print $2}' | sed 's/[^0-9.].*//')
major=${version_num%%.*}
minor=${version_num#*.}
minor=${minor%%.*}

if ((major > 3)) || { ((major == 3)) && ((minor >= 2)); }; then
	tmux bind-key -r "$KEY" display-popup -E "$LAUNCH"
else
	tmux bind-key -r "$KEY" neww "$LAUNCH"
fi
tmux set -s command-alias new-layout="run-shell '$NEW_LAYOUT'"
