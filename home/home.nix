{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    #Module imports
    ./home-packages.nix
    ./modules/fish/fish.nix
    ./modules/cursor/cursor.nix
    ./modules/starship/starship.nix
    ./modules/nvf/nvf.nix
    ./modules/fastfetch/fastfetch.nix
    ./modules/cava/cava.nix
    ./modules/kitty/kitty.nix
    ./modules/zed/zed.nix

    #DMS shell input import
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dsearch.homeModules.default
  ];

  fonts.fontconfig.enable = true;

  home.username = "greed";
  home.homeDirectory = "/home/greed";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
