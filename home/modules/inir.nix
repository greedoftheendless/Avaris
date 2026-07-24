{...}: {
  programs.inir = {
    enable = true;
    service.compositor = "niri";
  };

  programs.inir.configSymlink.enable = true;
}
