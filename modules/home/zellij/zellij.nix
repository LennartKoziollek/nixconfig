{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.home.programs.zellij;
in {
  options.modules.home.programs.zellij = {
    enable = lib.mkEnableOption "Enable zellij";
  };

  config = lib.mkIf cfg.enable {
    # Track zellij git package until 0.41.0 is in nixpkgs
    home.packages =
      if pkgs.system == "aarch64-darwin"
      then [inputs.nixpkgs.legacyPackages."aarch64-darwin".zellij]
      else [pkgs.zellij];

    xdg.configFile."zellij/config.kdl".text = builtins.readFile ./config.kdl;
    # xdg.configFile."zellij/layouts/default.kdl".text = builtins.readFile ./layouts/default.kdl;
  };
}
