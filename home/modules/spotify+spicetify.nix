{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  programs.spicetify = {
    enable = true;

    #extensions
    enabledExtensions = with spicePkgs.extensions; [
      hidePodcasts
      shuffle
      oneko
      catJamSynced
      spicyLyrics
      availabilityMap
    ];

    #themes and colorSchemes
    theme = spicePkgs.themes.starryNight;
    colorScheme = "Base";
  };
}
