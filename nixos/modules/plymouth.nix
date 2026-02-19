{ pkgs, ... }: {
  boot = {

    plymouth = {
      enable = true;
      theme = "darth_vader";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "darth_vader" ];
        })
      ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    #This gives 3 second time for bootloader to show(ur generationns) then automatically chooses the default one which is the 1st one.
    loader.timeout = 3;

  };
}
