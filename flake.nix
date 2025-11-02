{
  description = "Greed's Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem = {
      url = "github:/feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae = {
      url = "github:/vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wifi-tui = {
      url = "github:/shazow/wifitui";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ ... }:
    {
      nixosConfigurations = {
        greed = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            nixos/configuration.nix
            nixos/system-packages.nix
            inputs.home-manager.nixosModules.default
            ({
              nix.settings.auto-optimise-store = true;

              #Automatic garbage collection of nix generations
              nix.gc = {
                automatic = true;
                dates = "daily";
                options = "--delete-older-than 10d";
              };
            })
          ];
        };
      };
    };
}
