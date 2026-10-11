{pkgs, ...}: {
  #Installing Packages
  environment.systemPackages = with pkgs; [
    #Terminal tools
    xwayland
    xwayland-satellite
    xwayland-run
    xdg-desktop-portal-gnome
    nh
    upower-notify
  ];
}
