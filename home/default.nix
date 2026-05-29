{inputs, ...}: {
  imports = [
    #Module imports
    ./packages/home-packages.nix
    ./packages/pentest-packages.nix
    ./packages/game.nix
    ./modules/fish.nix
    ./modules/cursor.nix
    ./modules/starship.nix
    ./modules/zed.nix
    ./modules/nvf/nvf.nix
    ./modules/fastfetch/fastfetch.nix
    ./modules/cava/cava.nix
    ./modules/kitty/kitty.nix
    ./modules/nixcord/nixcord.nix

    #Importing home
    ./home.nix

    #Nixcord import
    inputs.nixcord.homeModules.nixcord
  ];
}
