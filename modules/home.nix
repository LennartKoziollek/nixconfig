{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let

  modules = lib.filterAttrs (n: v: v == "directory") (builtins.readDir ./.);

  importModule = name: let
    mod = import ./${name}/${name}.nix {inherit lib config inputs pkgs;};
  in
    if builtins.hasAttr "home" mod
    then mod.home
    else {};
in {
  imports = lib.mapAttrsToList (name: _: importModule name) modules;
}
