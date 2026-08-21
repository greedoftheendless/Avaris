{inputs, ...}: {
  imports = [inputs.qylock.nixosModules.default];

  programs.qylock = {
    enable = true;

    # theme = "osu";
    # theme = "ninja_gaiden";
    theme = "clockwork/orbital";
    # theme = "nier-automata";

    sddm.enable = true;
    quickshell.enable = true;
  };
}
