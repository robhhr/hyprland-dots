config files for fedora hyprland

neovim config [repository](https://github.com/robhhr/nvim-world)

#### todo

- [ ] hyprland: enable notify-send on exec-once

#### notes

##### alacritty

- theme toggle: use symlink with installed themes

```
ln -sf ~/.config/alacritty/themes/themes/gruvbox_material_hard_dark.toml \
       ~/.config/alacritty/active-theme.toml
```

##### tmux

- theme toggle: use symlink with installed themes

```
mkdir -p ~/.config/tmux-themes
ln -sf ~/.config/tmux-themes/gruvbox-dark.conf ~/.config/tmux-themes/active.conf
```

##### theme script (DIY)

- `mkdir -p ~/.config/theme && echo "dark" > ~/.config/theme/current`
- `chmod +x ~/bin/toggle-theme`

