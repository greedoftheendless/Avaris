{pkgs, ...}: {
  #Adding nix-experimental command features and nix flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  #Pointing nh the direction of flake
  environment.sessionVariables = {
    NH_FLAKE = "/home/greed/dotfiles";
  };

  nixpkgs.config.allowUnfree = true;
  nix.package = pkgs.nixVersions.latest;
}
