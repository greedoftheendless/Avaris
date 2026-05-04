{
  programs.nixcord = {
    enable = true;

    #Choosing discord client
    discord.enable = false;
    vesktop.enable = true;

    # Theming
    quickCss = "/* css goes here */";
    config = {
      useQuickCss = true;
      themeLinks = [
        "https://raw.githubusercontent.com/ClearVision/ClearVision-v7/master/ClearVision-v7.theme.css"
      ];
      frameless = true;

      disableMinSize = true;
      plugins = {
        crashHandler.enable = true;
        fakeNitro.enable = true;
        webScreenShareFixes.enable = true;
        petpet.enable = true;
        noTypingAnimation.enable = true;
        silentTyping.enable = true;
        validReply.enable = true;
        quickReply.enable = true;
      };
    };
  };
}
