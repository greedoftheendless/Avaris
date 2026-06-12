{
  ... 
}:{
  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--preview"
      "bat --color=always {}"
      "--preview-window=right:60%"
    ];
  };
};
