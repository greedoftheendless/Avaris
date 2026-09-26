{...}: {
  programs.nushell = {
    enable = true;

    configFile.text = ''
      #Welcome message
      print $"🦊 Welcome, ($env.USER)!"

      #Default editor
      $env.config.buffer_editor = "nvim"
      $env.config.show_banner = false

      #Alias
      alias sf = superfile
      alias docker = podman
      alias grep = rg
      alias zed = zeditor
      alias nv = nvim
      alias yz = yazi
      alias lz = lazygit
      alias cat = bat
      alias la = eza -a --long --icons --color=always
      alias "..." = cd ../..
      alias ".." = cd ..

      alias lgit = lazygit
      alias gd = git diff
      alias ga = git add
      alias gs = git status
      alias gc = git commit -m
      alias gp = git push

      alias jji = jj split -i
      alias jjb = jj bookmark list
      alias jjs = jj status
      alias jjl = jj log
      alias jjd = jj diff -r
      alias jjde = jj diffedit
      alias jjc = jj commit -m
      alias jjt = jj bookmark advance --to @-
      alias jjp = jj git push --bookmark

      $env.PATH = ($env.PATH | prepend ($env.HOME | path join ".local/bin"))

      #Source for atuin
      source ~/.local/share/atuin/init.nu
      source ~/.local/share/atuin/pty-proxy-init.nu

      #Source for zoxide
      source ~/.zoxide.nu

    '';
  };
}
