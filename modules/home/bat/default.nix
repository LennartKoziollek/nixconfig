{
  config,
  lib,
  ...
}: let
  cfg = config.modules.home.programs.bat;
in {
  options.modules.home.programs.bat = {
    enable = lib.mkEnableOption "Enable bat";
  };

  config = lib.mkIf cfg.enable {
    programs.bat = {
      enable = true;
    };
  };
}
