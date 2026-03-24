{ pkgs, ... }:
{
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.rose-pine-cursor;
    size = 24;
    name = "BreezeX-RosePine-Linux";
  };
}
