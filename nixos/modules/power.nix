{isLaptop, ...}: {
  powerManagement = {
    enable = true;
    # disbale USB after sometime of inactivity
    powertop.enable = isLaptop;
  };
  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true; # conflict with TLP
    tlp.enable = false;
    libinput.enable = isLaptop;
  };
}
