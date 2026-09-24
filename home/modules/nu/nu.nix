{
  config,
  pkgs,
  ...
}: {
  programs.nushell = {
    enable = true;

    # Options mapped directly into Nushell's $env.config
    configFile.text = ''
      $env.config.buffer_editor = "nvim"
      $env.config.show_banner = false

      print "🦊 Welcome, greed!"
    '';
  };
}
