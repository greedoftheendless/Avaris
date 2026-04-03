{ pkgs, ... }:
{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # lets you use `docker` cli as alias
  };

  environment.systemPackages = with pkgs; [
    podman-compose
  ];
}
