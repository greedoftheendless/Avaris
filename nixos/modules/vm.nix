{
  flake.modules.nixos.services_virtualisation = {
    config,
    pkgs,
    ...
  }: let
    inherit (config.custom.constants) user;
  in {
    config = {
      virtualisation = {
        libvirtd.enable = true;
        # following configuration is used only when building VMs with build-vm
        vmVariant = {
          virtualisation = {
            memorySize = 1024 * 6;
            cores = 4;
          };
        };
      };
      programs.virt-manager.enable = true;
      environment.systemPackages = with pkgs; [virtiofsd];

      users.users.${user}.extraGroups = ["libvirtd"];
    };
  };
}
