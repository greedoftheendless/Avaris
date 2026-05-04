{
  pkgs,
  inputs,
  ...
}: {
  #Installing DMS Shell by passing imports
  #programs.dank-material-shell = {
  #enable = true;
  #};

  #Installing Dsearch by passing imports
  #programs.dsearch = {
  #enable =true;
  #};

  home.packages = with pkgs; [
    (import ./modules/webapp/webapp-install.nix {inherit pkgs;})
    (import ./modules/webapp/webapp-uninstall.nix {inherit pkgs;})

    (writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        nix-search-tv
      ];
      # prevent IFD, thanks @Michael-C-Buckley
      text = ''exec "${pkgs.nix-search-tv.src}/nixpkgs.sh" "$@"'';
    })

    (writeShellApplication {
      name = "nix-check";
      runtimeInputs = with pkgs; [
        nix
        curl
        jq
        coreutils
        gnused
      ];
      text = builtins.readFile ./modules/nix-check/nix-check.sh;
    })

    #Game Mods
    lovely-injector

    #Shells
    bash
    nushell

    #Hyprland/Niri required packages
    #waybar
    hyprlock
    hyprshot
    #wlogout
    #waypaper
    awww
    #mpvpaper
    #hyprshot
    pastel

    # CLI Tools
    evtest
    zoxide
    onefetch
    ffmpeg
    jq
    tmux
    atuin
    fzf
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
    git
    gource
    tealdeer
    navi
    nemo
    nautilus
    kdePackages.gwenview
    superfile
    btop
    binutils
    lazygit
    gh
    unzip
    openvpn
    caffeine-ng
    typst
    inputs.wifi-tui.packages.${pkgs.stdenv.hostPlatform.system}.default

    #Pentesting and related tools
    netdiscover
    nmap
    wpscan
    nftables
    ffuf
    wirelesstools
    sqlmap
    john
    enum4linux
    netcat
    thc-hydra
    metasploit
    aircrack-ng
    crunch
    nikto
    hashcat
    exploitdb
    steghide
    bettercap
    unixtools.netstat
    burpsuite
    stegseek
    theharvester
    binwalk
    tcpdump

    # Web/Common Apps
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
