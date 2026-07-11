{ ... }:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen-beta.desktop";
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "text/plain" = "nvim.desktop";
      "inode/directory" = "org.gnome.Nautilus.desktop";
      "image/*" = "org.kde.gwenview.desktop";
      "video/*" = "vlc.desktop";
      "audio/*" = "vlc.desktop";
      "application/pdf" = "zen-beta.desktop";
      "x-terminal-emulator" = "kitty.desktop";
    };
  };

  home.sessionVariables = {
    BROWSER = "zen-beta";
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "kitty";
    FILE_MANAGER = "nautilus";
  };
}
