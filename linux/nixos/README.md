# NixOS Setup

## 1. Core Tools

Download and setup config file from `configuration.nix`.

## 2. Keyboard

Add dvorak and querty in KDE ui, extra key modifiers are already in nix config

## 3. Window Manager

KDE comes with KWIN just import the `kdeshortcuts.kksrc` file in the shortcut settings

## 4. Config files

Ghostty, git and tmux can't have their config done via nix so, gitconfig goes in the `$HOME` directory and the other two in `$HOME/.config`

## 5. Scripts

Add local scripts in `.local/bin`
