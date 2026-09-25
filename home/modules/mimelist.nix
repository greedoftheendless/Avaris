{...}: {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen-beta.desktop";
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "text/plain" = "nvim.desktop";
      "inode/directory" = "org.gnome.Nautilus.desktop";
      "image/jpeg" = "org.kde.gwenview.desktop";
      "image/png" = "org.kde.gwenview.desktop";
      "image/gif" = "org.kde.gwenview.desktop";
      "image/webp" = "org.kde.gwenview.desktop";
      "image/bmp" = "org.kde.gwenview.desktop";
      "image/tiff" = "org.kde.gwenview.desktop";
      "image/avif" = "org.kde.gwenview.desktop";
      "image/heif" = "org.kde.gwenview.desktop";
      "image/svg+xml" = "org.kde.gwenview.desktop";
      "video/mp4" = "vlc.desktop";
      "video/mkv" = "vlc.desktop";
      "video/webm" = "vlc.desktop";
      "video/x-matroska" = "vlc.desktop";
      "video/avi" = "vlc.desktop";
      "video/quicktime" = "vlc.desktop";
      "audio/mpeg" = "vlc.desktop";
      "audio/flac" = "vlc.desktop";
      "audio/ogg" = "vlc.desktop";
      "audio/wav" = "vlc.desktop";
      "audio/x-opus+ogg" = "vlc.desktop";
      "application/pdf" = "org.pwmt.zathura.desktop";
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
