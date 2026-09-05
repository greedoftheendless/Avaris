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
    uv
    fuzzel
    hyprpicker
    libnotify
    go
    wlsunset
    easyeffects
    swappy
    tesseract
    mission-center
    mpv
    swaylock
    swayidle
  ];
}
