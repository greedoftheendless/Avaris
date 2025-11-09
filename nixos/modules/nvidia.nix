{
  lib,
  config,
  ...
}: let
  cfg = config.modules.nvidia;
in {
  options.modules.nvidia = {
    enable = lib.mkEnableOption "nvidia drivers with prime";
    withSpecialisation = lib.mkEnableOption "gaming specialization";
  };
  config = lib.mkIf cfg.enable {
    services.xserver = {
      videoDrivers = ["nvidia"];
    };

    hardware.nvidia = {
      modesetting.enable = true;
      nvidiaSettings = false;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      open = true;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        amdgpuBusId = "PCI:6:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    specialisation = lib.mkIf cfg.withSpecialisation {
      gaming.configuration = {
        hardware.nvidia = {
          powerManagement.finegrained = lib.mkForce false;
          prime.sync.enable = lib.mkForce true;
          prime.offload = {
            enable = lib.mkForce false;
            enableOffloadCmd = lib.mkForce false;
          };
        };
      };
    };
  };
}
