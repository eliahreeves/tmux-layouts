CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/variables.sh"
pane_current_path=$(tmux display-message -p '#{pane_current_path}')
file=$(echo "$pane_current_path" | sed 's|^/||; s|/|.|g')
file="${CONFIG_DIR}${file}.yaml"
if [[ -f "$file" ]]; then
	tmux display-message "$file already exists"
else
	touch "$file"
	tmux display-message "created: $file"
fi
