{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/nvidia.nix
    ./modules/sddm.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "greed";

  # Enable networking
  networking.networkmanager.enable = true;

  #Enable bluetooth
  hardware.bluetooth.enable = true;

  #Enable TLP for power management
  services.tlp.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

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

  modules.nvidia.enable = true;
  modules.nvidia.withSpecialisation = true;

  system.stateVersion = "25.05";
}
