{pkgs, ...}: {
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
    upower-notify
    pkgs.adwaita-icon-theme
    swaynotificationcenter

    #qylock dependencies
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-libav
    qt6.qtmultimedia
  ];
}
