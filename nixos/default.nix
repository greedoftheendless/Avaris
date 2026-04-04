{
  imports = [
    ./modules/core.nix
    ./modules/networking.nix
    ./modules/flake-point.nix
    ./ideapad/hardware-configuration.nix
    ./ideapad/nvidia.nix
    ./modules/plymouth.nix
    ./modules/power.nix
    ./modules/podman.nix
    ./modules/font.nix
  ];
}
