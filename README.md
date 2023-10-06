# NixOS Configuration
```bash
sudo nixos-rebuild --flake .#default switch
```

### Desktop Configuration

#### StartX
***.xinitrc***
```bash
#!/bin/sh
startxfce4
```
#### Desktop Environment (XFCE)
In the XFCE start up programs add the XFCE Panel to refresh it upon log in to prevent an issue where it doesn't show, and add Xmonad to that list aswell. Then go in to the keyboard shortcuts and delete everything as they will block the use of Xmonads keybindings.

#### Window Manager (Xmonad)
In the start up programs for XFCE you want to add Xmonad this is the cleanest way to start Xmonad with XFCE that I have found, also the fastest.

### Virtualization Configuration
Kernel Parameters needed for Virtualization
```nix
  boot.kernelParams = [
    "amd_iommu=on"
    "iommu=pt"
    "iommu=1"
  ];
```

##### ACS Patch Override
```nix
  boot.kernelPackages = pkgs.linuxPackages_latest;
  nixpkgs.config.packageOverrides = pkgs: {
      linux_latest = pkgs.linux_latest.override {
        kernelPatches = pkgs.linux_latest.kernelPatches ++ [
          { name = "acs";
            patch = pkgs.fetchurl {
              url = "https://aur.archlinux.org/cgit/aur.git/plain/add-acs-overrides.patch?h=linux-vfio";
              sha256 = "b90be7b79652be61f7d50691000f6a8c75a240dc2eee2667b68d984f67583f77";
            };
          }
        ];
      };
    };
```

```nix
  boot.kernelParams = [
    "amd_iommu=on"
    "iommu=pt"
    "iommu=1"
    "pcie_acs_override=downstream,multifunction"
  ];
```

