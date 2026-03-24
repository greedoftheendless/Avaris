{
  pkgs,
  inputs,
  ...
}: {
  #Installing podman
  services.podman = {
    enable = true;
  };

  #Installing zed
  programs.zed-editor = {
    enable = true;
  };

  #Installing kitty
  programs.kitty = {
    enable = true;
  };

  #Installing cava
  programs.cava = {
    enable = true;
  };

  #Installing fastfetch
  programs.fastfetch = {
    enable = true;
  };

  #Installing fish
  programs.fish = {
    enable = true;
  };
  #Installing starship
  programs.starship = {
    enable = true;
  };

  #Installing vesktop
  programs.vesktop = {
    enable = true;
  };

  #Installing nvf
  programs.nvf = {
    enable = true;
  };

  #Installing fzf
  programs.fzf = {
    enable = true;
  };

  #Installing zoxide
  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
  };

  #Installing DMS Shell by passing imports
  programs.dankMaterialShell = {
    enable = true;
  };

  #Installing Dsearch by passing imports
  programs.dsearch = {
    enable = true;
  };

  home.packages = with pkgs; [
    (import ./modules/webapp/webapp-install.nix {inherit pkgs;})
    (import ./modules/webapp/webapp-uninstall.nix {inherit pkgs;})

    (
      writeShellApplication
      {
        name = "ns";
        runtimeInputs = with pkgs; [
          fzf
          nix-search-tv
        ];
        # prevent IFD, thanks @Michael-C-Buckley
        text = ''exec "${pkgs.nix-search-tv.src}/nixpkgs.sh" "$@"'';
      }
    )

    #Shells
    bash
    nushell

    #Hyprland/Niri required packages
    waybar
    waypaper
    hyprlock
    wlogout
    #waypaper
    swww
    mpvpaper
    #hyprshot
    pastel

    # CLI Tools
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
    cacert
    playerctl
    bc
    brightnessctl
    usbguard
    usbguard-notifier
    ghostty
    git
    tealdeer
    navi
    nemo
    nautilus
    kdePackages.gwenview
    wiki-tui
    yazi
    superfile
    btop
    binutils
    lazygit
    gh
    unzip
    openvpn
    podman-tui
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
    wpscan
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
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    wget
    curl
    spotify
    dropbox
    obsidian
    protonvpn-gui
    cava
    obs-studio
    protonplus
  ];
}
