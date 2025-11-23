{ pkgs, config, ... }:
{
  programs.rmpc = {
    enable = true;
    config = # ron
      ''
        #![enable(implicit_some)]
        #![enable(unwrap_newtypes)]
        #![enable(unwrap_variant_newtypes)]
        (
            address: "127.0.0.1:6600",
            theme: Some("default"),
            cache_dir: "~/.cache/rmpc/",
            volume_step: 2,
            scrolloff: 2,
            enable_mouse: true,
            wrap_navigation: true,
            status_update_interval_ms: 1000,
            keybinds: (
                global: {
                    "1":       QueueTab,
                    "2":       DirectoriesTab,
                    "3":       ArtistsTab,
                    "4":       AlbumsTab,
                    "5":       PlaylistsTab,
                    "6":       SearchTab,
                    "?":       ShowHelp,
                    "q":       Quit,
                    "<Space>":  TogglePause,
                    "n":       NextTrack,
                    "N":       PreviousTrack,
                    ".":       SeekForward,
                    ",":       SeekBack,
                    "r":       ToggleRandom,
                    "R":       ToggleRepeat,
                },
                navigation: {
                    "g":        Top,
                    "G":        Bottom,
                    "<CR>":     Confirm,
                    "j":        Down,
                    "k":        Up,
                    "/":        EnterSearch,
                    "<Esc>":    Close,
                    "<Space>":  Add,
                },
            ),
        )
      '';
  };

  services.mpd = {
    enable = true;
    musicDirectory = config.xdg.userDirs.music;
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "Pipewire"
      }
      auto_update "yes"
    '';
  };
}
