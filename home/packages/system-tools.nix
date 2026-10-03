{pkgs, ...}: {
  #Installing web-apps
  home.packages = with pkgs; [
    #Terminal needed shells
    bash

    #System/Niri required packages
    awww
    pastel

    # CLI Tools
    zoxide
    onefetch
    ffmpeg
    jq
    tmux
    openssl
    bat
    tree
    fd
    ripgrep

    #Languages and their packages
    python3

    #Tunelling proxy/VPN(Self-Host)
    wireguard-ui
    wireguard-tools

    cacert
    playerctl
    bc
    brightnessctl
    ghostty
    jujutsu
    git
    lazygit
    gh
    gource
    tealdeer
    navi
    nautilus
    kdePackages.gwenview
    wl-clipboard
    wget
    curl
    file
    xdg-utils
    xdg-user-dirs
    pulseaudio
    btop
    binutils
    unzip
    openvpn
    typst
  ];
}
