{ config, pkgs, ... }:

{

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.autorun = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.startx.enable = true;

  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.plasma5.runUsingSystemd = false;

  services.xserver.desktopManager.xterm.enable = true;

  services.xserver.desktopManager.xfce = {
    enable = true;
    noDesktop = true;
    enableXfwm = false;
  };
  services.xserver.windowManager = {
    xmonad = {
      enable = true;
      enableContribAndExtras = true;
      enableConfiguredRecompile = true;
      extraPackages = haskellPackages : [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
      ];
    };
  };
  services.xserver.displayManager.defaultSession = "xfce+xmonad";




#  services.xserver.desktopManager.plasma5.enable = true;
#  services.xserver.windowManager.bspwm.enable = true;
#  services.xserver.windowManager.bspwm.configFile = "/etc/nixos/config/bspwm/bspwmrc";
#  services.xserver.windowManager.bspwm.sxhkd.configFile = "/etc/nixos/config/bspwm/sxhkdrc";

#  systemd.services.plasma-bspwm = {
#    enable = true;
#    description = "Launch Plasma on bspwm";
#    wantedBy = ["plasma-workspace.target"];
#    unitConfig = {
#      Before = "plasma-workspace.target";
#    };
#    serviceConfig = {
#      ExecStart = "${pkgs.bspwm}/bin/bspwm";
#      };
#  };
}
