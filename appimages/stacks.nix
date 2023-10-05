{ pkgs, lib, fetchurl, writeScriptBin, stdenv }:

stdenv.mkDerivation rec {
  pname = "stacks";
  version = "2.3.4"; # Replace with the actual version of your AppImage.

  src = fetchurl {
    url = "https://github.com/stacks-task-manager/stacks2/releases/download/v2.3.4/Stacks-Linux-2.3.4.AppImage"; # Replace with the URL of your .AppImage file.
    sha256 = "956a56a0e44271076c8f9fb327f32a0f5cfd9a6347976f94bda41aac82bf4c13"; # Replace with the SHA256 hash of the .AppImage file.
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/my-app
    chmod +x $out/bin/my-app
  '';

  meta = with lib; {
    description = "Stacks";
    license = licenses.mit;
  };
}
