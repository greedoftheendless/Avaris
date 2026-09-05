{pkgs, ...}: {
  programs.inir = {
    enable = true;
    service.enable = true;
    service.compositor = "niri";
  };

  programs.inir.configSymlink.enable = true;
}
