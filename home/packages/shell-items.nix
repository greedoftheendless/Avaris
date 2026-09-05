{pkgs, ...}: {
  home.packages = with pkgs; [
    # inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    # dms-shell
    noctalia-shell

    #Items
    wf-recorder
    slurp
    grim
    darkly
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
