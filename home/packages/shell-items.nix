{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    #iNiR import
    # inputs.inir.homeModules.inir

    #noctalia import
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    #umbriel import
    inputs.umbriel.packages.${pkgs.stdenv.hostPlatform.system}.default

    dms-shell

    #Items
    wf-recorder
    slurp
    grim
    gpu-screen-recorder
    quickshell
    fuzzel
    hyprpicker
    libnotify
    wlsunset
    easyeffects
    swappy
    tesseract
    mission-center
    mpv
    swaylock
    swayidle
    ddcutil
    qt5.qtgraphicaleffects
  ];
}
