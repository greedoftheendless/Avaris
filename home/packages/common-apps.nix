{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    syncthing
    wl-clipboard
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
    gimp
    imagemagick
    localsend
    telegram-desktop
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    firefox
    wget
    curl
    # obsidian
    zennotes-desktop
    proton-vpn
    cava
    obs-studio
    protonplus
    opencode
  ];
}
