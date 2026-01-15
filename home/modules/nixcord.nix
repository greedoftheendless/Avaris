# home.nix
{
  # ...
  programs.nixcord = {
    enable = true;          # Enable Nixcord (It also installs Discord)
    vesktop.enable = true;  # Vesktop
    quickCss = "some CSS";  # quickCSS file
    config = {
      useQuickCss = true;   # use out quickCSS
      themeLinks = [        # or use an online theme
        "https://raw.githubusercontent.com/link/to/some/theme.css"
      ];
      frameless = true;                   # Set some Vencord/Equicord options
      plugins = {
        hideAttachments.enable = true;    # Enable a plugin (works with both Vencord and Equicord)
        ignoreActivities = {              # Enable a plugin and set some options
          enable = true;
          ignorePlaying = true;
          ignoreWatching = true;
          ignoredActivities = [ "someActivity" ];
        };
      };
    };
    dorion = {
      theme = "dark";
      zoom = "1.1";
      blur = "acrylic";       # "none", "blur", or "acrylic"
      sysTray = true;
      openOnStartup = false;
      autoClearCache = true;
      disableHardwareAccel = false;
      rpcServer = true;
      rpcProcessScanner = true;
      pushToTalk = true;
      pushToTalkKeys = ["RControl"];
      desktopNotifications = true;
      unreadBadge = true;
    };
    extraConfig = {
      # Some extra JSON config here
      # ...
    };
  };
  # ...
}
