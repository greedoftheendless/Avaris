{
  config,
  pkgs,
  ...
}:
with lib; {
    programs.vesktop = {
      enable = true;

      plugins = {
        AlwaysAnimate.enable = true;
        ClearURLs.enable = true;
        DontRoundMyTimestamps.enable = true;
        ExpressionCloner.enable = true;
        FakeNitro.enable = true;
        MessageClickActions.enable = true;
        petpet.enable = true;
        ShowHiddenChannels.enable = true;
        SilentTyping.enable = true;
        ThemeAttributes.enable = true;
        TypingIndicator.enable = true;
      };

      theme = "NotAnotherAnimeTheme";
    };
  };
}
