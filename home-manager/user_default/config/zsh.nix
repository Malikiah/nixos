{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    profileExtra = ''
      if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]
      then
        exec startx &>/dev/null
      fi
      '';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    shellAliases = {
        ls = "ls -lah";
      };
    zplug = {
      enable = true;
          plugins = [
            { 
	      name = "zsh-users/zsh-autosuggestions";
	      } # Simple plugin installation
            { 
	      name = "romkatv/powerlevel10k";
	      tags = [ as:theme depth:1 ];
	      } # Installations with additional options. For the list of options, please refer to Zplug README.
          ];

    };
    initExtra = ''
      source ./.p10k.zsh
    '';
  };

}
