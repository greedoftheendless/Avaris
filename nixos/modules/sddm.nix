{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.modules.sddm;
in {
  options.modules.sddm = {
    enable = lib.mkEnableOption "sddm";
  };
  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = let
      silent-sddm = inputs.silentSDDM.packages.${pkgs.stdenv.hostPlatform.system}.default;
    in {
      enable = true;
      package = pkgs.kdePackages.sddm;
      wayland.enable = true;
      theme = lib.mkForce "silent";
      settings = {
        General = {
          GreeterEnvironment = "QML2_IMPORT_PATH=${silent-sddm}/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard";
          InputMethod = "qtvirtualkeyboard";
        };
      };
      extraPackages = [
        silent-sddm
        pkgs.kdePackages.qtmultimedia
        pkgs.kdePackages.qtbase
        pkgs.kdePackages.qtwayland
        pkgs.kdePackages.qtmultimedia
      ];
    };

    environment.systemPackages = [
      inputs.silentSDDM.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
