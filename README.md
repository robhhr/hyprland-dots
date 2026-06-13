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


#### how to configure theme switch (for future machines)

1. theme state file
`mkdir -p ~/.config/theme && echo "dark" > ~/.config/theme/current`

2. alacritty symlink
```
ln -sf ~/.config/alacritty/themes/themes/gruvbox_material_hard_dark.toml \
       ~/.config/alacritty/active-theme.toml
```

3. tmux themes dir + symlink
```
mkdir -p ~/.config/tmux-themes
ln -sf ~/.config/tmux-themes/gruvbox-dark.conf ~/.config/tmux-themes/active.conf
```

4. toggle script
```
mkdir -p ~/bin
cp ~/.config/scripts/toggle-theme ~/bin/toggle-theme  # or recreate from repo
chmod +x ~/bin/toggle-theme
```

5. make sure ~/bin is in PATH (if not already in .zshrc)
`echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc`
