{pkgs, ...}: {
  home.packages = with pkgs; [
    lovely-injector
    osu-lazer-bin
    lutris
    gamemode
    mangohud
    protonplus
  ];
}
