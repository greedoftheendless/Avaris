{
  config,
  pkgs,
  inputs,
  ...
}:
{
  modules.nvidia.enable = true;
  modules.nvidia.withSpecialisation = true;

  programs.niri.enable = true;

  #Enabling SSDM login screen
  #services.displayManager.sddm.enable = true;

  #Enabling ly login manager
  services.displayManager.ly.enable = true;

  #Home-manager config
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      greed = import ../../home/default.nix;
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account.
  users.users.greed = {
    isNormalUser = true;
    description = "Greed";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "input"
      "wireshark"
    ];
    shell = pkgs.fish;
    ignoreShellProgramCheck = true;
  };

  boot.loader.systemd-boot.memtest86.enable = true;

  environment.variables = {
    NIXOS_OZONE_WL = "1";

    ELECTRON_LAUNCH_FLAGS = "--enable-wayland-ime --wayland-text-input-version=3 --enable-features=WaylandLinuxDrmSyncobj";
  };

  system.stateVersion = "25.05";
}
