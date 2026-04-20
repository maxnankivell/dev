# macOS Setup

## 1. Core Tools

Install and configure these tools before anything else.

- **Zsh**: Comes pre-installed on macOS. Verify with `zsh --version`.
- **Homebrew**: Install from https://brew.sh/
- **Git**: `brew install git`, then download `.gitconfig` and setup signing key
- **VS Code**: Download and turn on settings sync or copy from `vscode/usersettings.json`.

---

## 2. Raycast

1. Download and install Raycast from https://www.raycast.com/
2. Open Raycast → `Raycast Settings` → `Advanced` → `Import Settings`
3. Import `raycast/Raycast 2026-04-12 15.03.18.rayconfig` to restore all settings and extensions

---

## 3. Karabiner-Elements

1. Install: by direct download or brew cask `brew install --cask karabiner-elements`
2. Open Karabiner-Elements at least once to grant the required permissions (System Settings → Privacy & Security → Input Monitoring)
3. Copy the config:
   ```sh
   cp -r .config/karabiner/ ~/.config/karabiner/
   ```

---

## 4. Ghostty

1. Install: by direct download or brew cask `brew install --cask ghostty`
2. Copy the config:
   ```sh
   mkdir -p ~/.config/ghostty
   cp .config/ghostty/config ~/.config/ghostty/config
   ```

---

## 5. fnm (Node Version Manager)

```sh
brew install fnm
```

fnm will be initialised by the `.zshrc` copied in step 8.

---

## 6. Oh My Zsh

Install from https://ohmyz.sh/ — run the install script shown on the homepage.

> This will overwrite your `~/.zshrc`. That's fine — you'll replace it in step 8.

---

## 7. Homebrew Tools

Install everything in one go:

```sh
brew install bat eza fastfetch fzf starship tmux zoxide zsh-syntax-highlighting
```

---

## 8. Shell Config (`.zshrc` and `.zprofile`)

Copy the dotfiles to your home directory:

```sh
cp .zshrc ~/.zshrc
cp .zprofile ~/.zprofile
```

**Before sourcing, remove the auto-generated pnpm block** at the bottom of `.zshrc` (lines managed by pnpm itself — reinstall pnpm later if needed and let it re-add its own block):

```zsh
# Remove this section:
export PNPM_HOME="/Users/maxnankivell/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
```

Also update the `PNPM_HOME` path if your username differs. Once cleaned up, reload:

```sh
source ~/.zshrc
```

---

## 9. Starship & Tmux Config

```sh
mkdir -p ~/.config/starship ~/.config/tmux
cp .config/starship.toml ~/.config/starship.toml
cp .config/tmux/tmux.conf ~/.config/tmux/tmux.conf
```

---

## 10. Local Bin Scripts

Copy the contents of `.local/` to your home `.local/` folder:

```sh
cp -r .local/ ~/.local/
chmod +x ~/.local/bin/*
```
