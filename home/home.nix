{ config, pkgs, inputs, ... }:

{
  imports = [
    ./home-packages.nix
    ./modules/fish.nix
    ./modules/cursor.nix
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dsearch.homeModules.default
  ];

  fonts.fontconfig.enable = true;

  home.username = "greed";
  home.homeDirectory = "/home/greed";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
