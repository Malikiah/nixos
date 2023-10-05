{ config, pkgs, ...}:

{
  programs.bash = {
    enable = true;
    profileExtra = ''
       if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]
       then
         exec startx
       fi
      '';
  };
}
