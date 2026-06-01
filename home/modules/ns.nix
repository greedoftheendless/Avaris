{
  pkgs,
  ...
}: {
      ns = pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [ fzf nix-search-tv ];
      checkPhase = "";
      text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
    };
in {
    home.packages = [ ns ];
    }
}
