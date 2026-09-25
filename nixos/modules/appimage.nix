{pkgs, ...}: {
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.appimage.package =
    pkgs.appimage-run.override
    {
      extraPkgs = pkgs: [
        pkgs.icu
        pkgs.libxcrypt-legacy
        pkgs.python312
        pkgs.python312Packages.torch
      ];
    };
}
