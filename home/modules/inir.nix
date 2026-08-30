{
  pkgs,
  inputs,
  ...
}: let
  inirMascot = import ../packages/inir-mascot.nix {inherit pkgs;};

  upstreamInir = inputs.iNiR.packages.${pkgs.stdenv.hostPlatform.system}.default;

  # Local fixes for NixOS: the upstream package targets Arch and hardcodes
  # /usr/bin paths; the Nix build strips that prefix but two things break as a
  # result, which makes window previews (Orbit / workspace strip) fail:
  #  1. capture-windows.fish still does `exec /usr/bin/bash` (the .fish files
  #     are not in the package's sed patch list) -> resolve bash from PATH.
  #  2. capture-windows.sh pre-checks each helper with `[[ -x "$bin" ]]`, which
  #     checks the CWD, not PATH, so bare names like `niri` "missing" -> use
  #     `command -v` (PATH lookup) instead, matching how the script actually
  #     invokes them later.
  inirPackage = pkgs.runCommand "inir-preview-fixed" {} ''
    cp -r --preserve=mode ${upstreamInir} $out
    chmod -R u+w $out
    substituteInPlace "$out/share/quickshell/inir/scripts/capture-windows.fish" \
      --replace-fail "exec /usr/bin/bash" "exec bash"
    sed -i 's|if \[\[ ! -x "\$bin" \]\]; then|if ! command -v "$bin" >/dev/null 2>\&1; then|' \
      "$out/share/quickshell/inir/scripts/capture-windows.sh"
  '';

  inirWithMascot = pkgs.symlinkJoin {
    name = "inir-with-mascot";
    paths = [inirPackage inirMascot];
    meta.mainProgram = "inir";
  };
in {
  programs.inir = {
    enable = true;
    service.enable = true;
    service.compositor = "niri";
    package = inirWithMascot;
  };

  programs.inir.configSymlink.enable = true;
}
