{ config, pkgs, ... }:
{
  users.groups.libvirtd.members = [ "root" "default"];

  virtualisation = {
	libvirtd = {
		enable = true;
		qemu = {
			swtpm.enable = true;
			ovmf.enable = true;
			ovmf.packages = [ 
				  (pkgs.OVMF.override {
        		  	    secureBoot = true;
        		  	    csmSupport = false;
        		  	    httpSupport = true;
        		  	    tpmSupport = true;
        		  	  }).fd
			];
		};
	};
	spiceUSBRedirection.enable = true;
  };
  
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  programs.dconf.enable = true;

### Single GPU Passthrough ###
  environment.etc."libvirt/qemu.conf" = {
    mode = "0755";
    source = config/libvirt/qemu.conf;
  };

  environment.etc."libvirt/libvirtd.conf" = {
    mode = "0755";
    source = config/libvirt/libvirtd.conf;
  };

  systemd.services."libvirt-nosleep@" = {
    enable = true;
    description = "Preventing sleep while libvirt domain \"%i\" is running";
    unitConfig = {
      Type = "simple";
    };
    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/systemd-inhibit --what=sleep --why=\"Libvirt domain \"%i\" is running\" --who=%U --mode=block sleep infinity";
      };
  };

}
