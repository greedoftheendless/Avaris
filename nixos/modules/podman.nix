{ pkgs, ... }:
{
  # Enable Podman and related tools
  virtualisation = {
    podman = {
      enable = true;
    };
    containers.enable = true;

    # Create a 'docker' alias for podman
    dockerCompat = true;

    # Required for containers to communicate with each other
    defaultNetwork.settings.dns_enabled = true;
  };

  # This section fixes the "short-name" error
  virtualisation.containers.registries.search = [
    "docker.io"
    "quay.io"
    "ghcr.io"
  ];

  # Useful packages for container management
  environment.systemPackages = with pkgs; [
    podman-compose # If you want to use docker-compose syntax
  ];
}
