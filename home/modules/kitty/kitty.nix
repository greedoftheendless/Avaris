{
  config,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };

    settings = {
      fallback_family = "Noto Sans Arabic";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      cursor_shape = "beam";

      include = "current-theme.conf";

      shell = "fish";
      background_opacity = "0.8";
      allow_remote_control = "yes";

      tab_bar_edge = "bottom";
      tab_bar_min_tabs = 2;
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      tab_activity_symbol = "0 ";

      tab_title_template = "{fmt.bold}{index}{'(%d)'%num_windows if num_windows > 1 else ''}: {(title.replace('ss@msi:', '')[:6]+'…'+title.replace('ss@msi:', '')[-6:]) if title.replace('ss@msi:', '').rindex(title.replace('ss@msi:', '')[-1]) + 1 > 13 else title.replace('ss@msi:', '')}";

      active_tab_title_template = "{'(%d)':%num_windows if num_windows > 1 else ''} {title}";
    };

    keybindings = {
      "alt+t" = "new_tab";
      "alt+q" = "close_tab";
      "alt+1" = "goto_tab 1";
      "alt+2" = "goto_tab 2";
      "alt+3" = "goto_tab 3";
      "alt+4" = "goto_tab 4";
      "alt+5" = "goto_tab 5";
      "alt+6" = "goto_tab 6";
      "alt+7" = "goto_tab 7";
      "alt+8" = "goto_tab 8";
      "alt+9" = "goto_tab 9";
      "alt+0" = "select_tab";
      "alt+h" = "previous_tab";

      "alt+shift+f" = "change_font_size current +1.00";
      "alt+f" = "change_font_size current -1.00";

      include = "current-theme.conf";
    };
  };

  xdg.configFile."kitty/current-theme.conf".source =
    ./current-theme.conf;

  xdg.configFile."kitty/dank-theme.conf".source =
    ./dank-theme.conf;

  xdg.configFile."kitty/dank-tabs.conf".source =
    ./dank-tabs.conf;
}
