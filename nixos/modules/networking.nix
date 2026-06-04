{...}: {
  # Enable networking
  networking.networkmanager.enable = true;

  #Enable firewall
  networking.firewall = {
  };

  # Enable SSH
  services.openssh.enable = true;

  #Adding bluetooth
  services.blueman.enable = true;

  #Enable bluetooth
  hardware.bluetooth.enable = true;

  networking.hostName = "greed";

  # Set your time zone.
  time.timeZone = "Asia/Qatar";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
