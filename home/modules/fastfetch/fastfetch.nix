{
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        source = "/home/greed/dotfiles/home/modules/fastfetch/Images/angel.jpg";
        height = 13;

        padding.middle = 1;
      };

      display.separator = " ";

      modules = [
        {
          type = "custom";
          key = "╭───────────────────────󰇴 الطم───────────────────";
        }
        {
          type = "os";
          format = "{2} {9}";
          key = "├──";
        }
        {
          type = "kernel";
          format = "{1} {2}";
          key = "│ ";
        }
        {
          type = "wm";
          key = "│ ";
        }
        {
          type = "shell";
          key = "│ ";
        }
        {
          type = "uptime";
          key = "│ ";
        }
        {
          type = "cpu";
          format = "{1}";
          key = "│ ";
        }
        {
          type = "gpu";
          format = "{1} {2}";
          key = "│󰢮 ";
        }
        {
          type = "memory";
          key = "│ ";
        }
        {
          type = "disk";
          folders = "/";
          format = "{1} / {2} ({3})";
          key = "│ ";
        }
        {
          type = "media";
          key = "├─󰝚";
        }
        {
          type = "custom";
          key = "╰───────────────────────󰇴 الطم───────────────────";
        }
      ];
    };
  };
}
