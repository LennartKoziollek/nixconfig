{
  nixpkgs,
  inputs,
  ...
}: let
  username = "lk";
  mod = ./split.nix;
in {
  testing = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ../hosts/tower/hardware-configuration.nix
      ../hosts/tower/configuration.nix
      mod
      {config.modules.desktop.hyprland.enable = true;}
    ];
    specialArgs = {
      inherit inputs;
    };
  };
}
