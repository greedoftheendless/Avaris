{
  description = "Greed's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    git-hooks.url = "github:cachix/git-hooks.nix";
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wifi-tui = {
      url = "github:shazow/wifitui";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dsearch = {
      url = "github:AvengeMedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default";
  };
  outputs =
    inputs@{
      self,
      systems,
      ...
    }:
    let
      forEachSystem = inputs.nixpkgs.lib.genAttrs (import systems);
    in
    {
      # Run hooks with `nix fmt`
      formatter = forEachSystem (
        system:
        let
          pkgs = inputs.nixpkgs.legacyPackages.${system};
          config = self.checks.${system}.pre-commit-check.config;
          inherit (config) package configFile;
          script = ''
            ${pkgs.lib.getExe package} run --all-files --config ${configFile}
          '';
        in
        pkgs.writeShellScriptBin "pre-commit-run" script
      );
      # Run hooks in sandbox with `nix flake check`
      checks = forEachSystem (system: {
        pre-commit-check = inputs.git-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixfmt.enable = true; # formats .nix files
            nil.enable = true; # nix semantic error checking
            typos.enable = true; # spell check code and comments
            check-merge-conflicts.enable = true; # catch unresolved merge conflicts
            check-case-conflicts.enable = true; # catch case-insensitive filename clashes
            check-added-large-files = {
              # change this
              enable = true;
              args = [ "--maxkb=15000" ];
            };
          };
        };
      });
      # Enter dev shell with `nix develop` — hooks install automatically
      devShells = forEachSystem (
        system:
        let
          pkgs = inputs.nixpkgs.legacyPackages.${system};
          inherit (self.checks.${system}.pre-commit-check) shellHook enabledPackages;
        in
        {
          default = pkgs.mkShell {
            inherit shellHook;
            buildInputs = enabledPackages;
          };
        }
      );
      nixosConfigurations = {
        greed = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./nixos/configuration.nix
            ./nixos/system-packages.nix
            inputs.home-manager.nixosModules.home-manager
            {
              nix.settings.auto-optimise-store = true;
              # automatic garbage collection of nix generations
              nix.gc = {
                automatic = true;
                dates = "daily";
                options = "--delete-older-than 10d";
              };
            }
          ];
        };
      };
    };
}
