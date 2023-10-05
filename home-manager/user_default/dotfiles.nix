{config, pkgs, ...}:

{
  home.file."nvim" = {
    enable = true;
    executable = true;
    recursive = true;
    source = ./home/.config/nvim;
    target = ".config/nvim";
  };
  
  home.file."xmonad" = {
    enable = true;
    executable = true;
    recursive = true;
    source = ./home/.xmonad/xmonad.hs;
    target = ".xmonad/xmonad.hs";
  };

  home.file."rofi-config" = {
    enable = true;
    executable = true;
    recursive = true;
    source = ./home/.config/rofi/config.rasi;
    target = ".config/rofi/config.rasi";
  };

  home.file."rofi-theme-launchpad" = {
    enable = true;
    executable = true;
    recursive = true;
    source = ./home/.config/rofi/themes/launchpad.rasi;
    target = ".config/rofi/themes/launchpad.rasi";
  };

  home.file."rofi-theme-spotlight-dark" = {
    enable = true;
    executable = true;
    recursive = true;
    source = ./home/.config/rofi/themes/spotlight-dark.rasi;
    target = ".config/rofi/themes/spotlight-dark.rasi";
  };

  home.file."p10k" = {
    enable = true;
    executable = true;
    recursive = true;
    source = ./home/.p10k.zsh;
    target = ".p10k.zsh";
  };

  home.file."alacritty" = {
    enable = true;
    executable = true;
    recursive = true;
    source = ./home/.config/alacritty;
    target = ".config/alacritty";
  };

  home.file."picom" = {
    enable = true;
    executable = true;
    recursive = true;
    source = ./home/.config/picom;
    target = ".config/picom";
  };

  home.file."redshift" = {
    enable = true;
    executable = true;
    recursive = false;
    source = ./home/.config/redshift.conf;
    target = ".config/redshift.conf";
  };

#### No Longer Use These Configs but are needed for different kinds of setups #####
  home.file."plasmaWorkspaceXmonadScript" = {
    enable = false;
    executable = true;
    recursive = true;
    source = ./home/.config/plasma-workspace/env/set_window_manager.sh;
    target = ".config/plasma-workspace/env/set_window_manager.sh";
  };

  home.file."bspwm" = {
    enable = false;
    executable = true;
    recursive = true;
    source = ./home/.config/bspwm;
    target = ".config/bspwm";
  };

  home.file."sxhkd" = {
    enable = false;
    executable = true;
    recursive = true;
    source = ./home/.config/sxhkd;
    target = ".config/sxhkd";
  };
}
