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
      la = "nu -c ls -la";
      "..." = "cd ../..";
      ".." = "cd ..";

      #for git commands
      lgit = "lazygit";
      gd = "git diff";
      ga = "git add";
      gs = "git status";
      gc = "git commit -m";
      gp = "git push";
    };

    interactiveShellInit = ''
      # Greeting
        set -g fish_greeting

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
    '';
  };
}
