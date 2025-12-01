{
  pkgs,
  inputs,
  ...
}:
{

  #Installing Helix
  programs.helix.enable = true;

  #Enable zoxide
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

    (import ./modules/webapp-install.nix { inherit pkgs; })
    (import ./modules/webapp-uninstall.nix  { inherit pkgs; })

    #Shells
    bash
    nushell

    #Hyprland/Niri required packages
    waybar
    hyprlock
    #hypridle
    #pywal
    #rofi
    wlogout
    #waypaper
    swww
    #mpvpaper
    #hyprshot
    hyprpicker
    ffmpeg
    #inputs.vicinae.packages.${pkgs.system}.default

    # CLI Tools
    claude-code
    tmux
    cava
    fastfetch
    atuin
    eza
    openssl
    bat
    tree
    fd

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
    nemo
    nautilus
    kdePackages.gwenview
    lf
    starship
    btop
    binutils
    lazygit
    gh
    unzip
    openvpn
    podman
    podman-tui
    caffeine-ng
    #kdePackages.okular
    typst
    inputs.wifi-tui.packages.${pkgs.system}.default

    #Pentesting and related tools
    netdiscover
    nmap
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
    onlyoffice-desktopeditors
    vlc
    catppuccin
    zed-editor
    thunderbird
    #librewolf
    tor-browser
    gimp3-with-plugins
    inputs.zen-browser.packages.${pkgs.system}.default
    wget
    curl
    spotify
    vesktop
    dropbox
    obsidian
    protonvpn-gui
    cava
    obs-studio
    protonplus
  ];
}
