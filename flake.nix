{
  description = "Greed's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixcord.url = "github:FlameFlag/nixcord";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-notes = {
      url = "github:ZenNotes/zennotes";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    iNiR = {
      url = "github:snowarch/iNiR/prerelease";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default";
  };
  outputs = inputs @ {
    self,
    systems,
    ...
  }: let
  in {
    nixosConfigurations = {
      greed = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./nixos/default.nix
          inputs.home-manager.nixosModules.home-manager
          {
            nix.settings.auto-optimise-store = true;
            # automatic garbage collection of nix generations
            nix.gc = {
              automatic = true;
              dates = "daily";
              options = "--delete-older-than 5d";
            };
          }
        ];
      };
    };
  };
}
