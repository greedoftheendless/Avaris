{inputs, ...}: {
  imports = [
    #Module imports
    ./packages/system-tools.nix
    ./packages/pentest-packages.nix
    ./packages/game.nix
    ./packages/common-apps.nix
    ./modules/fzf.nix
    ./modules/fish.nix
    ./modules/ns.nix
    ./modules/cursor.nix
    ./modules/starship.nix
    ./modules/zed.nix
    ./modules/nvf/nvf.nix
    ./modules/fastfetch/fastfetch.nix
    ./modules/cava/cava.nix
    ./modules/kitty/kitty.nix
    ./modules/nixcord/nixcord.nix
    ./modules/tmux.nix

    #Importing home
    ./home.nix

    #Nixcord import
    inputs.nixcord.homeModules.nixcord
  ];
}
