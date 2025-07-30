# tmux-layouts

## Purpose

I keep all my projects in a single directory and I wanted to be able to launch a fuzzy finder to open a new tmux session, optionally, with a layout. This behavior is similar to "sessionizer." The additional functionality I wanted was to be able to write a config file to describe what windows to open.

## Installation
#### Requirements
- tmux
   Pretty much any version should work.
### Install with TPM
#### Dependencies
- fzf

    A very useful fuzzy finder.
- yq

    A YAML counterpart to jq. Parses YAML files in the command line.

First add this line to your config:
```bash
set -g @plugin 'eliahreeves/tmux-layouts'
```

Next set a parameter to tell tmux-layouts where to look. If the path does not end in * it will be included in the list. If it does then the foulders inside will be included. For example `~/repos` will be the literal repos folder, where as `~/repos/*` will be everything inside repos:
```bash
set -g @layouts-project-paths '~/repos/*;~/.config;~/.dotfiles'
```
This is a list of directories separated by semicolons.

Optionally set a key to trigger tmux-layouts. The default is prefix+f.
```bash
set -g @layouts-finder-key 'f'
```

Optionally set a path to look for configs. The default is `~/.tmux/layouts/`
```bash
set -g @layouts-config-path '~/.tmux/layouts/'
```
### Install with Nix home-manager or NixOS
You can package the plugin in your config or a module like this:
```nix
# tmux-module.nix
{pkgs, ...}: let
  layouts = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "layouts";
    version = "0.1.0";
    rtpFilePath = "layouts.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "eliahreeves";
      repo = "tmux-layouts";
      rev = "e98a7a05e9eee5e4e064789779120de19288c7fe";
      sha256 = "sha256-fVJp10cCJPq4HENPh2gcljPUd7Q3Jqu3OO7kp0ZCOUc=";
    };
    postInstall = ''
      sed -i -e 's|\bfzf\b|${pkgs.fzf}/bin/fzf|g' $target/scripts/launch.sh
      sed -i -e 's|\byq\b|${pkgs.yq-go}/bin/yq|g' $target/scripts/launch.sh
    '';
  };
in {
  programs.tmux = {
    enable = true;
    plugins = [
      {
        plugin = layouts;
        extraConfig = ''
          set -g @layouts-project-paths '~/repos'
          set -g @layouts-finder-key 'f'
        '';
      }
    ];
  };
}
```
## Usage

Just activate tmux-layouts and fuzzy find your session. To create window layout for a project, create a YAML file in the config folder. The filename should be the full path to your project without the first `/` and with all subsequent `/`'s replaced with `.` and a .yaml extension. To output this filename for your current directory you can use: 
```bash
echo "$(pwd | sed 's|^/||; s|/|.|g').yaml"
```
This file can be created in your config folder for your current directory with prefix+:new-layout

The YAML format is as follows:
```yaml
name: "My Project"              # session name
windows:
    - name: "editor"            # window name
      path: "~/example/path"    # window path
      command: "nvim"           # command to run       
      run: flase                # if this is false the command will be typed but not run, default true
    - name: "zsh"
```
Note that all options in the YAML file are optional.

## Alternatives
- [tmuxinator](https://github.com/tmuxinator/tmuxinator)

    I haven't used it, but it looks pretty cool. Certainly more feature rich. I don't like that it isn't a simple plugin that can be added with TPM.

- [zellij](https://github.com/zellij-org/zellij)

    Not tmux but the layout engine offers solutions for a similar problem.

