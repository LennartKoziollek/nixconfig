{
  nixpkgs,
  self,
  hyprland,
  ...
}: let

  tower = import ./tower;

  inputs = self.inputs; # make flake inputs accessible
  bootloader = ../modules/core/bootloader.nix;
  core = ../modules/core;
  wayland = ../modules/wayland;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs; # make flake inputs accessible to home manager
      inherit self;
    };
    users.lk = ../modules/home; # where the user config lifes
  };
in {
  # TODO: make this smaller
  xi = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux"; # double defined this FIX
    modules = [
      {
        networking.hostName = "xi";
      }
      ./xi/hardware-configuration.nix
      bootloader
      core
      wayland
      hmModule
      {inherit home-manager;} # this pulls down the config we have defined in let
    ];
    specialArgs = {inherit inputs;};
  };

  # TODO: look into packages that have to be inherited.
  # {inherit base-options}
  tower = nixpkgs.lib.nixosSystem (tower);
}
