# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’). 
{ config, pkgs, ... }: 

{

  nix = {
      package = pkgs.nixFlakes;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
  };
  imports = [ # Include the results of the hardware scan. 
    ./hardware-configuration.nix
    ./desktop.nix
    ./virtualization.nix
    ./config/libvirt/single-gpu-passthrough/qemu.nix
    ./config/libvirt/single-gpu-passthrough/vfio-scripts.nix
    ]; 

  #Bootloader. 
  boot.loader.systemd-boot.enable = true; 
  boot.loader.efi.canTouchEfiVariables = true; 

  #Setup keyfile 
  boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };

  boot.kernelPackages = pkgs.linuxPackages_6_4;

  boot.kernelParams = [ 
    "amd_iommu=on"
    "iommu=pt"
    "pcie_acs_override=downstream,multifunction"
  ];
  boot.kernelPatches = [
    { 
      name = "add-acs-overrides";
      patch = pkgs.fetchurl {
        name = "add-acs-overrides.patch";
	url = "https://aur.archlinux.org/cgit/aur.git/plain/0001-add-acs-overrides.patch?h=linux-vfio&id=1a1a7ab832756f4fc4e93f569d541127e90bcdd3";
	sha256 = "bdd2a5a56e01e91723907afb40d28bed77b7d5107aba92c85adb3ce6967e713a";
      };
    }
    {
      name = "i915-vga-arbiter";
      patch = pkgs.fetchurl {
        name = "i915-vga-arbiter.patch";
        url = "https://aur.archlinux.org/cgit/aur.git/plain/0002-i915-vga-arbiter.patch?h=linux-vfio&id=1a1a7ab832756f4fc4e93f569d541127e90bcdd3";
          #url =
          #  "https://aur.archlinux.org/cgit/aur.git/plain/i915-vga-arbiter.patch?h=linux-vfio&id=${acscommit}";
          sha256 = "9a698eaf1a0bd740981e909b6ad9bd41300488a2a771843bf30b9bdc94aa3c3b";
        };
      }
  ];

  boot.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  # Enable CUPS to print documents.
  services.printing.enable = false;


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.default = {
    isNormalUser = true;
    description = "default";
    extraGroups = [ "networkmanager" "wheel" "libvirt" "input" "kvm"];
    packages = with pkgs; [ 

    ];
  };
  
  nixpkgs.config = { 
    allowUnfree = true;
    permittedInsecurePackages = [
    ];
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ##### XFCE Packages #####
    xfce.xfwm4
    xfce.thunar
    xfce.xfdesktop
    xfce.xfce4-panel
    xfce.xfce4-whiskermenu-plugin

    blueberry # blueberry is a bluetooth application that has a systray
    pasystray # pasystray is a (Pulse Audio | PipeWire) systray 
    pavucontrol # pavucontrol is an application for editing audio (PulseAudio | PipeWire)

    librewolf # Firefox with High Security Settings, and AdBlock
    firefox
    brave # Chromium Based Browser, with Builtin AdBlock

    onlyoffice-bin # OpenSource Office like application
    neovim # VIM on with extra stuff
    vim
    alacritty # Rust Based Terminal Emulator https://alacritty.org/
    zsh # Improved Shell
    git # Code Repository Commandline Tool
    picom # Compositor for Desktop
    obsidian # Note Taking Application
    vscode
    rofi
    #redshift

    nextcloud-client

    ##### Utilities
    file
    unzip
    killall
    dmg2img
    gnumake
    gcc9
    tree
    pkgs.libsForQt5.spectacle
    testdisk


    ##### Network Packages #####
    nmap
    inetutils
    iputils
    wget
    dig
   
    ##### Virtualization Packages
    qemu
    virt-viewer
    virt-manager
    spice-vdagent
    spice-protocol
    spice spice-gtk

    pkgs.xorg.xrandr # Used to determine what display outs for monitors
    pkgs.xorg.xev # Used to determine keybindings for bspwm
    pkgs.xorg.xinit # Used for the startx displaymanager
    pkgs.dbus 
    
    ##### Hardware Querying Packing#####
    pciutils

    ##### Media Packages #####
    gimp # Gimp is a photo editng application
    rawtherapee # Raw photo editing Application, this software is used to edit raw images and can import them into gimp https://rawtherapee.com/
    vlc

    ##### Forensic Tools #####
    ##### Perl #####

    ##### Python Packages #####
    (python310.withPackages(ps: with ps; [ 
      selenium 
      tkinter
    ]))

    #(import ./appimages/stacks.nix) # Import the custom package definition.

  ];


  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  hardware.bluetooth.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?


}


