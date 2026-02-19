{ config, pkgs, ... }:

{
  services.logind = {
    idleAction = "suspend";
    idleActionSec = "20min";
  };
}
