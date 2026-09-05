{inputs, ...}: {
  imports = [
    #Module imports
    ./packages/system-tools.nix
    ./packages/shell-items.nix
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
    ./modules/spotify+spicetify.nix
    ./modules/default-app.nix
    ./modules/inir.nix

    #iNiR import
    inputs.iNiR.homeModules.inir

    #Nixcord import
    inputs.nixcord.homeModules.nixcord

    #Spicetify import
    inputs.spicetify-nix.homeManagerModules.spicetify

    #Importing home
    ./home.nix
  ];
}
