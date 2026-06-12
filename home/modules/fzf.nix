{...}: {
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultOptions = [
      "--preview 'bat --color=always {}'"
      "--preview-window=right:60%"
    ];
  };
}
