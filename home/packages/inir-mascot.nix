{ pkgs, ... }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "inir-mascot";
  version = "3";

  src = pkgs.fetchurl {
    url = "https://github.com/snowarch/inir-mascot/releases/latest/download/inir-mascot-pack.tar.gz";
    hash = "sha256-DCkWHOVa/7N9FlGD+XdVBuyXRnlWf+3Kv3Lp9f9aw5s=";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/quickshell/inir/assets/images/mascot"
    tar xf "$src" -C "$out/share/quickshell/inir/assets/images/mascot/"

    runHook postInstall
  '';

  meta = {
    description = "iNiR mascot art pack (354 poses/animations)";
    homepage = "https://github.com/snowarch/inir-mascot";
    license = pkgs.lib.licenses.mit;
    platforms = pkgs.lib.platforms.linux;
  };
}
