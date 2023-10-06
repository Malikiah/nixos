{ pkgs, ... }:
{
    home.file.xinitrc = {
      enable = true;
      text = ''
#!/bin/sh
export WINDOW_MANAGER=xmonad
startplasma-x11 &
xmonad
      '';
      target = ".xinitrc";
    };
}
	# picom &
	# startxfce4 &
	# startxfce4
        # startplasma-x11 &
