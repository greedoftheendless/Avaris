{
  pkgs,
  inputs,
  ...
}: {
  #Installing web-apps
  home.packages = with pkgs; [
    (import ../modules/webapp/webapp-install.nix {inherit pkgs;})
    (import ../modules/webapp/webapp-uninstall.nix {inherit pkgs;})

    #Shells
    bash
    nushell
    noctalia-shell
    # dms-shell
    quickshell

    #System/Niri required packages
    awww
    pastel

    # CLI Tools
    zoxide
    onefetch
    ffmpeg
    jq
    tmux
    atuin
    eza
    openssl
    bat
    tree
    fd
    ripgrep

    #Languages and their packages
    python3

    # Necessary tools
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    cacert
    playerctl
    bc
    brightnessctl
    usbguard
    usbguard-notifier
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
    superfile
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
