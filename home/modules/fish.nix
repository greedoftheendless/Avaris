{...}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      #Apps
      sf = "superfile";
      docker = "podman";
      grep = "rg";
      zed = "zeditor";
      nv = "nvim";
      yz = "yazi";
      lz = "lazygit";

      #Everyday commands
      cat = "bat";
      cd = "z";
      ls = "nu -c ls";
      la = "eza -a --long --icons --color=always";
      "..." = "cd ../..";
      ".." = "cd ..";

      #for git commands
      lgit = "lazygit";
      gd = "git diff";
      ga = "git add";
      gs = "git status";
      gc = "git commit -m";
      gp = "git push";

      #Alias for jj
      jji = "jj split -i";
      jjb = "jj bookmark list";
      jjs = "jj status";
      jjl = "jj log";
      jjd = "jj diff -r";
      jjde = "jj diffedit";
      jjc = "jj commit -m";
      jjt = "jj bookmark advance --to @-";
      jjp = "jj git push --bookmark";
    };

    # plugins = with pkgs.fishPlugins; [
    #   {
    #     name = "z";
    #     src = z.src;
    #   }
    #   {
    #     name = "fzf";
    #     src = fzf.src;
    #   }
    # ];

    interactiveShellInit = ''
      # Greeting
      set -g fish_greeting "🦊 Welcome, $USER!"

      # Enable/Disable fish autosuggestions
      # set -g fish_autosuggestion_enabled 0

      # Atuin shell history
       atuin init fish | sed 's/-k up/up/' | source

       # Zoxide integration
       zoxide init fish | source

       # Enable completion colors
       set -g fish_color_autosuggestion brblack
       set -g fish_color_command green
       set -g fish_color_param white
       set -g fish_color_comment yellow

       # Universal variables (example subset)
       set -U fish_color_cancel -r
       set -U fish_color_command normal
       set -U fish_color_comment red
       set -U fish_color_user brgreen
       set -U fish_user_paths /nix/store/i24mfkgsg2zjqh0jasw2pw3jxjqldp-ghostty-1.2.2/bin

       # Completions
       set -p fish_complete_path ~/.nix-profile/share/fish/vendor_completions.d
       set -p fish_complete_path /etc/profiles/per-user/$USER/share/fish/vendor_completions.d
       set -p fish_complete_path /run/current-system/sw/share/fish/vendor_completions.d
    '';
  };
}
