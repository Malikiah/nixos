{ pkgs, home, ... }: {
  xsession.windowManager.xmonad = {
    enable = true;
    extraPackages = haskellPackages: [
      haskellPackages.xmonad
      haskellPackages.xmonad-contrib
      haskellPackages.ghc
    ];
    enableContribAndExtras = true;
    config = home/.config/xmonad/xmonad.hs;
  };
}
