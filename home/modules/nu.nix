{...}: {
  programs.nushell = {
    enable = true;

    configFile.text = ''
      $env.config = {
        show_banner: false
        completions: {
          case_sensitive: false
          quick: true
          partial: true
          algorithm: "fuzzy"
        }
      }

      zoxide init nushell | save -f ~/.zoxide.nu
      source ~/.zoxide.nu
      source ~/.local/share/atuin/pty-proxy-init.nu
      source ~/.local/share/atuin/init.nu
    '';

    shellAliases = {
      # Apps
      sf = "superfile";
      docker = "podman";
      grep = "rg";
      zed = "zeditor";
      nv = "nvim";
      yz = "yazi";
      lz = "lazygit";

      # Everyday commands
      cat = "bat";
      cd = "z";
      "..." = "cd ../..";
      ".." = "cd ..";

      # Git commands
      lgit = "lazygit";
      gd = "git diff";
      ga = "git add";
      gs = "git status";
      gc = "git commit -m";
      gp = "git push";
    };
  };
}
