{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.nvidia;
in
{
  options.modules.nvidia = {
    enable = lib.mkEnableOption "nvidia drivers with prime";
    withSpecialisation = lib.mkEnableOption "gaming specialization";
  };
  config = lib.mkIf cfg.enable {
    services.xserver = {
      videoDrivers = [ "nvidia" ];
    };

    hardware.nvidia = {
      modesetting.enable = true;
      nvidiaSettings = false;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      open = true;

      # Apply CachyOS kernel 6.19 patch to NVIDIA latest driver
      package =
        let
          base = config.boot.kernelPackages.nvidiaPackages.latest;
          cachyos-nvidia-patch = pkgs.fetchpatch {
            url = "https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/nvidia/nvidia-utils/kernel-6.19.patch";
            sha256 = "sha256-YuJjSUXE6jYSuZySYGnWSNG5sfVei7vvxDcHx3K+IN4=";
          };

          # Patch the appropriate driver based on config.hardware.nvidia.open
          driverAttr = if config.hardware.nvidia.open then "open" else "bin";
        in
        base
        // {
          ${driverAttr} = base.${driverAttr}.overrideAttrs (oldAttrs: {
            patches = (oldAttrs.patches or [ ]) ++ [ cachyos-nvidia-patch ];
          });
        };

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
