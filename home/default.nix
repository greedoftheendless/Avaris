{inputs, ...}: {
  imports = [
    #Module imports
    ./home-packages.nix
    ./modules/fish.nix
    ./modules/cursor.nix
    ./modules/starship.nix
    ./modules/zed.nix
    ./modules/nvf/nvf.nix
    ./modules/fastfetch/fastfetch.nix
    ./modules/cava/cava.nix
    ./modules/kitty/kitty.nix
    ./modules/nixcord/nixcord.nix

    #Window manager imports
    #./window-managers/niri.nix

    #Importing home
    ./home.nix

    #Nixcord import
    inputs.nixcord.homeModules.nixcord

    #DMS shell input import
    #inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    #inputs.dsearch.homeModules.default
  ];
}
