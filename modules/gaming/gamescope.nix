{ config, lib, ... }: with lib; let
  username = config.modules.user.username;
  cfg = config.modules.programs.gamescope;
in {
  options.modules.programs.lutris.enable = mkEnableOption "Enable Gamescope";

  config = mkIf cfg.enable {
    programs.gamescope = {
      enable = true;
    };
  };
}
