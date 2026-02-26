_: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      command_timeout = 1000;
      line_break = {
        disabled = true;
      };
      git_status = {
        disabled = true;
      };
      directory = {
        truncation_length = 3;
        truncate_to_repo = false;
        truncation_symbol = "…/";
      };
      directory.read_only = " 󰌾";
      git_branch.symbol = " ";
      hostname.ssh_symbol = " ";
      nix_shell.symbol = " ";
      package.symbol = "󰏗 ";
      rust.symbol = " ";
      python.symbol = " ";
      lua.symbol = " ";
    };
  };
}
