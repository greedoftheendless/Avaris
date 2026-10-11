{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.qylock.nixosModules.default];

  programs.qylock = {
    enable = true;

    # theme = "osu";
    # theme = "ninja_gaiden";
    # theme = "clockwork/orbital";
    theme = "nier-automata";
    # theme = "enfield";
    # theme = "winter";
    # theme = "R1999_2";
    # theme = "sword";

    sddm.enable = true;
    quickshell.enable = true;
  };

  #qylock dependencies
  environment.systemPackages = with pkgs; [
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-libav
    qt6.qtmultimedia
    qt6.qt5compat
    qt6.qtsvg
  ];
}
