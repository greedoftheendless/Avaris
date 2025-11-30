# nixos/modules/sysc-greet.nix
{ lib, config, pkgs, ... }:

let
  cfg = config.services.sysc-greet;
in
{
  options.services.sysc-greet = {
    enable = lib.mkEnableOption "sysc-greet display manager";

    compositor = lib.mkOption {
      type = lib.types.str;
      default = "niri";
      description = "Which compositor to start via sysc-greet.";
    };

    settings.initial_session = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = "Optional auto-login session settings.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;

      settings = {
        default_session = {
          command = cfg.settings.initial_session.command or cfg.compositor;
          user = cfg.settings.initial_session.user or null;
        };
      };
    };
  };
}
