{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.dms-plugin-registry.nixosModules.default];
  programs.dms-shell = {
    enable = true;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}
