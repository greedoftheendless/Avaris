{pkgs, ...}: {
  #Fonts
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      merriweather
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts._0xproto
      nerd-fonts.iosevka-term-slab
      fira-code-symbols
      noto-fonts
      noto-fonts-lgc-plus
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      papirus-icon-theme
    ];
  };
}
