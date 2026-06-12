{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    lovely-injector
    osu-lazer-bin
    gamemode
  ];
}
