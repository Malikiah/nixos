### Window Manger
Window Manager is bspwm the directories for its configuration are linked to
- ./config/bspwm
- ./config/sxhkd

### Desktop Manager
The desktop manager sitting over bspwm is KDE Plasma.

#### Compositor
The compositor used with this configuration is Picom, to get Picom to work correctly you will need to disable the compositor on startup for Plasma.

#### Plasma Configuration Directories
- **Configuration Files**:
    Global Plasma Configuration: /usr/share/plasma/
    User-Specific Configuration: ~/.config/
        Plasma-related configuration files are typically stored in directories starting with "plasma" or "kde" within ~/.config/.

- **Desktop Widgets (Plasmoids)**:
    Global Widget Files: /usr/share/plasma/plasmoids/
    User-Specific Widget Files: ~/.local/share/plasma/plasmoids/

- **Themes**:
    Plasma Desktop Themes: /usr/share/plasma/desktoptheme/
    User-Specific Desktop Themes: ~/.local/share/plasma/desktoptheme/

- **Icons**:
    Icon Themes: /usr/share/icons/
    User-Specific Icon Themes: ~/.local/share/icons/

- **Wallpapers**:
    Global Wallpapers: /usr/share/wallpapers/
    User-Specific Wallpapers: ~/Pictures/Wallpapers/ (or any location you choose)

- **Desktop Files and Shortcuts**:
    Global Desktop Files: /usr/share/applications/
    User-Specific Desktop Files: ~/.local/share/applications/

- **Autostart Applications**:
    Global Autostart: /etc/xdg/autostart/
    User-Specific Autostart: ~/.config/autostart/

- **KDE Plasma Theme File**:
    Global Theme File: /usr/share/plasma/desktoptheme/default/ (The file "metadata.desktop" within this directory defines the default KDE Plasma theme.)

### Neovim
Install vim plugins after nixos configuration

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

```bash
nvim
:PlugInstall
:UpdateRemotePlugins
:q!
```
