{ pkgs, ... }: let
  username = import ../../username.nix;
in {
  # here you can add packages specific to your setup.
  programs.zsh.enable = true;
}
