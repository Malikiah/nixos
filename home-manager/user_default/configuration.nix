{config, pkgs, ...}:

{
  imports = [
    ./dotfiles.nix
    ./config/zsh.nix
    ./config/bash.nix
    ./config/xinitrc.nix
#    ./xmonad.nix
  ];

  home.username = "default";
  home.homeDirectory = "/home/default";
  home.stateVersion = "23.05";
  home.packages = [ 
    pkgs.vimPlugins.vim-plug
  ];
  programs.home-manager.enable = true;

}
