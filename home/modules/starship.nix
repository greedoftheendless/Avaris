{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}:
with lib; {
  programs.starship.settings = {
    # Format of the prompt
    format = "$username$hostname$directory$git_branch$git_status$python$rust$lua$line_break$jobs$status$character";

    # Character module (the prompt symbol)
    character = {
      success_symbol = "[❯](bold cyan)";
      error_symbol = "[❯](bold red)";
    };

    # Username module
    username = {
      show_always = false;
      format = "[$user]($style)@";
      style_user = "bold cyan";
    };

    # Hostname module
    hostname = {
      ssh_only = true;
      format = "[$hostname]($style) ";
      style = "bold blue";
    };

    # Directory module
    directory = {
      truncation_length = 3;
      format = "[$path]($style) ";
      style = "bold cyan";
      read_only = " 🔒";
      read_only_style = "red";
    };

    # Git branch module
    git_branch = {
      format = "[$symbol$branch]($style) ";
      symbol = "󰊢 ";
      style = "bold purple";
    };

    # Git status module (simplified)
    git_status = {
      format = "([$all_status$ahead_behind]($style))";
      style = "bold red";
      modified = "!";
      staged = "+";
      ahead = "⇡";
      behind = "⇣";
      diverged = "⇕";
    };

    # Python module
    python = {
      format = "with [$symbol($version)]($style) ";
      symbol = "🐍 ";
      style = "bold yellow";
      disabled = false;
    };

    # Rust module
    rust = {
      format = "with [$symbol($version)]($style) ";
      symbol = "🦀 ";
      style = "bold red";
      disabled = false;
    };

    # Lua module
    lua = {
      format = "with [$symbol($version)]($style) ";
      symbol = "🌙 ";
      style = "bold blue";
      disabled = false;
    };

    # Status module (exit code)
    status = {
      format = "[$symbol$status]($style) ";
      symbol = "✖";
      style = "bold red";
      disabled = false;
    };

    # Jobs module
    jobs = {
      format = "[$symbol$number]($style) ";
      symbol = "✦ ";
      style = "bold blue";
    };

    # Line break
    line_break = {
      disabled = false;
    };
  };
}
