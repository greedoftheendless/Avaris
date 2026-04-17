{
  description = "nix-check — a fast flake-aware nix update checker";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        nix-check = pkgs.writeShellApplication {
          name = "nix-check";

          # runtime deps — these get patched into PATH automatically
          runtimeInputs = with pkgs; [
            nix
            curl
            jq
            coreutils # date, seq, etc.
            gnused
          ];

          text = builtins.readFile ./nix-check.sh;
        };
      in
      {
        packages = {
          inherit nix-check;
          default = nix-check;
        };

        # nix run .
        apps.default = {
          type = "app";
          program = "${nix-check}/bin/nix-check";
        };

        # nix develop — for hacking on the script
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nix
            curl
            jq
            shellcheck # lint your sh
            bash
          ];
        };
      }
    );
}
