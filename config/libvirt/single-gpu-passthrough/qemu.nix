{ config, pkgs, ... }:

{
  environment.etc."libvirt/hooks/qemu" = {
    mode = "0755";
    source = ./scripts/qemu.sh;
  };
}
