{
  pkgs,
  inputs,
  ...
}: let
  original = inputs.zen-notes.packages.${pkgs.stdenv.hostPlatform.system}.zennotes-desktop;
in
  pkgs.symlinkJoin {
    name = original.name;
    paths = [
      original
      (pkgs.runCommand "zennotes-desktop-bin" {
          nativeBuildInputs = [pkgs.makeWrapper];
        } ''
          mkdir -p $out/bin
          makeWrapper ${original}/bin/zennotes-desktop $out/bin/zennotes-desktop \
            --prefix LD_LIBRARY_PATH : ${pkgs.libglvnd}/lib
        '')
    ];
  }
