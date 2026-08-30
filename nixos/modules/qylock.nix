{inputs, ...}: {
  imports = [inputs.qylock.nixosModules.default];

  programs.qylock = {
    enable = true;

    # theme = "osu";
    # theme = "ninja_gaiden";
    # theme = "clockwork/orbital";
    # theme = "nier-automata";
    theme = "enfield";
    # theme = "winter";
    # theme = "R1999_2";
    # theme = "sword";

    sddm.enable = true;
    quickshell.enable = true;
  };
}
