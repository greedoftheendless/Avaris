{
  pkgs,
  inputs,
  ...
}: {
  #Installing Packages
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
    xdg-desktop-portal-gnome
    nh
    #better-control
    libsForQt5.qt5.qttools
    upower-notify
    pkgs.adwaita-icon-theme
    swaynotificationcenter
  ];
}
