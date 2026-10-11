{pkgs, ...}: {
  home.pointerCursor = {
    enable = true;
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";
    size = 24;
  };

  home.packages = with pkgs; [
    adwaita-icon-theme
    rose-pine-cursor
    libxcursor
    xcursorthemes
  ];
}
