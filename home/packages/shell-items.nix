{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    #umbriel import
    inputs.umbriel.packages.${pkgs.stdenv.hostPlatform.system}.default

    dms-shell
    noctalia

    #Items
    slurp
    grim
    quickshell
    fuzzel
    hyprpicker
    libnotify
    satty
    dsearch
  ];
}
