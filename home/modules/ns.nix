{pkgs}:
pkgs.writeShellApplication {
  name = "ns";
  runtimeInputs = [pkgs.nix-search-tv];
  text = ''
    nix-search-tv nixpkgs "$@"
  '';
}
