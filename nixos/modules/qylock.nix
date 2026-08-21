{
  inputs,
  ...
}: {
  imports = [inputs.qylock.nixosModules.default];

  programs.qylock = {
    enable = true;
    theme = "osu";
    sddm.enable = true;
    quickshell.enable = true;

    themeOptions.osu.gameMode = "menu";
  };
}
