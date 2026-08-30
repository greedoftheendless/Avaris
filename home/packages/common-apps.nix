{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    syncthing
    cliphist
    libqalculate
    onlyoffice-desktopeditors
    zathura
    w3m
    vlc
    yazi
    catppuccin
    thunderbird
    tor-browser
    ascii-image-converter
    gimp
    imagemagick
    localsend
    telegram-desktop
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    firefox
    cmatrix
    # obsidian
    zennotes-desktop
    cava
    glow
    opencode
    obs-studio
    wf-recorder
    slurp
  ];
}
