{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    wl-clipboard
    onlyoffice-desktopeditors
    vlc
    catppuccin
    thunderbird
    tor-browser
    gimp
    localsend
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    firefox
    wget
    curl
    spotify
    dropbox
    obsidian
    proton-vpn
    cava
    obs-studio
    protonplus
    opencode
  ];
}
