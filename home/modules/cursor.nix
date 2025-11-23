{ pkgs, ... }:
{
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.rose-pine-cursor;
    size = 30;
    name = "rose-pine";
  };
}
