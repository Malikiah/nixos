{ pkgs, builtins, ... }:
#
#stdenv.mkDerivation {
#  name = "vfio-startup";
#  src = ./scripts/vfio-startup.sh;
#  phases = [ "installPhase" ];
#  installPhase = ''
#    mkdir -p /etc/libvirt/hooks/
#    cp $src /etc/libvirt/hooks/vfio-startup
#    chmod +x /etc/libvirt/hooks/vfio-startup
#  '';
#}
{
  environment.etc."libvirt/hooks/vfio-startup" = {
    mode = "0755";
    source = ./scripts/vfio-startup.sh;
  };

  environment.etc."libvirt/hooks/vfio-teardown" = {
    mode = "0755";
    source = ./scripts/vfio-teardown.sh;
  };
}
#pkgs.writeTextFile {
#  name = "vfio-startup";
#  text = builtins.readFile ./scripts/vfio-startup.sh;
#  destination = "/etc/libvirt/hooks/vfio-startup";
#}
