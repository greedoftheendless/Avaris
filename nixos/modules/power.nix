{ config, pkgs, ... }:

{
  _module.args.isLaptop = true;

  # Power management
  powerManagement = {
    enable = true;
    # Apply powertop auto-tuning (USB autosuspend etc.)
    powertop.enable = true;
  };

  # Services
  services = {
    # Needed for battery info, desktop environments, etc.
    upower.enable = true;

    # Modern power profile manager (DO NOT enable TLP with this)
    power-profiles-daemon.enable = true;

    # Disabled because it conflicts with power-profiles-daemon
    tlp.enable = false;

    # Touchpad / input handling (laptop only)
    libinput.enable = true;
  };
}
