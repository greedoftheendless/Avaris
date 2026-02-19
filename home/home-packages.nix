{
  pkgs,
  inputs,
  ...
}:
{
  #Installing podman
  services.podman = {
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
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.dankMaterialShell = {
    enable = true;
  };

  programs.dsearch = {
      enable = true;
  };

  #Enable hyprpanel
  #programs.hyprpanel.enable = true;

  home.packages = with pkgs; [

    (import ./modules/webapp/webapp-install.nix { inherit pkgs; })
    (import ./modules/webapp/webapp-uninstall.nix  { inherit pkgs; })

    #Shells
    bash
    nushell

    #Hyprland/Niri required packages
    waybar
    waypaper
    hyprlock
    #hypridle
    #rofi
    wlogout
    #waypaper
    swww
    mpvpaper
    #hyprshot
    pastel
    ffmpeg
    #inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default

    # CLI Tools
    tmux
    cava
    fastfetch
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
    playerctl
    bc
    brightnessctl
    usbguard
    usbguard-notifier
    ghostty
    #alacritty
    kitty
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
    davinci-resolve
    vlc
    catppuccin
    zed-editor
    thunderbird
    #librewolf
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
