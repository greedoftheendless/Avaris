{
  pkgs,
  inputs,
  ...
}:
{
  # Enable SSH
  services.openssh.enable = true;
  #Adding bluetooth
  services.blueman.enable = true;
  #Adding power-management
  services.upower.enable = true;
  #Adding nix-experimental command features and nix flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  #Pointing nh the direction of flake
  environment.sessionVariables = {
    NH_FLAKE = "$HOME/dotfiles";
  };
  nixpkgs.config.allowUnfree = true;
  nix.package = pkgs.nixVersions.latest;

  #Enabling/Installing hyprland
  programs.hyprland.enable = true;

  #Enabling/Installing niri
  programs.niri.enable = true;  # ADD THIS LINE

  #Enabling SSDM login screen
  services.displayManager.sddm.enable = true;

  #Home-manager config
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      greed = import ../home/home.nix;
    };
  };
  #Installing applications/packages using enable option
  programs.steam.enable = true;
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  environment.systemPackages = with pkgs; [
    #Terminal tools
    xwayland
    xwayland-satellite
    xwayland-run
    nh
    better-control
    upower
    libsForQt5.qt5.qttools
    upower-notify
    nwg-look
    nwg-menu
    pkgs.adwaita-icon-theme
    swaynotificationcenter
    tlp
  ];
  #Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts._0xproto
    nerd-fonts.iosevka-term-slab
    fira-code-symbols
    noto-fonts
    noto-fonts-lgc-plus
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    papirus-icon-theme
    tokyonight-gtk-theme
  ];
}
