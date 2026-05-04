{
  programs.nixcord = {
    enable = true;

    #Choosing discord client
    discord.vencord.enable = true;

    # Theming
    quickCss = "/* css goes here */";
    config = {
      useQuickCss = true;
      themeLinks = [
        ~/.config/vesktop/themes/ClearVision-v7-BetterDiscord.theme.css
      ];
      frameless = true;

      plugins = {
        hideAttachments.enable = true;
        ignoreActivities = {
          enable = true;
          ignorePlaying = true;
          ];
        };
      };
    };
  };
}
