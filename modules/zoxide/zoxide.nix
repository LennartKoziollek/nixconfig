{
  pkgs,
  lib,
  config,
  ...
}: let
  username = config.modules.user.username;
  cfg = config.modules.programs.zoxide;
  zsh = config.modules.programs.zsh.enable;
in {
  options.modules.programs.zoxide.enable = lib.mkEnableOption "Enable zoxide";

  home = {
    config = lib.mkIf cfg.enable {
      home-manager.users.${username} = {
        programs.zoxide = {
          enable = true;
          enableZshIntegration =
            if zsh
            then true
            else false;
        };
      };
    };
  };
}
