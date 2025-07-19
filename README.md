# tmux-sessions

## Purpose

I keep all my projects in a single directory and I wanted to be able to launch a fuzzy finder to open a new tmux session. This behavior is similar to "sessionizer." The additional functionality I wanted was to be able to write a config file to describe what windows to open.

## Installation

### Dependencies

- fzf

    A very useful fuzzy finder.
- yq

    A YAML counterpart to jq. Parses YAML files in the command line.
- tmux

    Obviously. Any version should do. If the version is new enough tmux-sessions will run in a popup.

Install this with TPM

First add this line to your config:
```bash
set -g @plugin 'eliahreeves/tmux-sessions'
```

Next set a parameter to tell tmux-sessions where to look:
```bash
set -g @sessions-project-paths '~/repos;~/.config;~/.dotfiles'
```
This is a list of directories separated by semicolons.

Optionally set a key to trigger tmux-sessions. The default is prefix+f.
```bash
set -g @sessions-finder-key 'f'
```

Optionally set a path to look for configs. The default is `~/.tmux/sessions/`
```bash
set -g @sessions-config-path '~/.tmux/sessions/'
```
## Usage

Just activate tmux-sessions and fuzzy find your session. To create window layout for a project, create a YAML file in the config folder. The filename should be the full path to your project without the first `/` and with all subsequent `/`'s replaced with `.` and a .yaml extension. To output this filename for your current directory you can use: 
```bash
echo "$(pwd | sed 's|^/||; s|/|.|g').yaml"
```

The YAML format is as follows:
```yaml
name: "My Project" # session name
windows:
    - name: "editor"
      path: "~/example/path"
      command: "nvim"
    - name: "zsh"
```
Note that all options in the yaml file are optional.

## Alternatives
- [tmuxinator](https://github.com/tmuxinator/tmuxinator)

    I haven't used it, but it looks pretty cool. Certainly more feature rich. I don't like that it isn't a simple plugin that can be added with TPM.

- [zellij](https://github.com/zellij-org/zellij)

    Not tmux but the layout engine offers solutions for a similar problem.

