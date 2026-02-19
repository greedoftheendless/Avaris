{ config, pkgs, inputs, ... }:

{
  imports = [
    #Module imports
    ./home-packages.nix
    ./modules/fish.nix
    ./modules/cursor.nix
    ./modules/starship.nix
    #./modules/vesktop.nix

    #Home Manager modules
    inputs.nvf.homeManagerModules.default

    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dsearch.homeModules.default
  ];

  fonts.fontconfig.enable = true;

  home.username = "greed";
  home.homeDirectory = "/home/greed";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
