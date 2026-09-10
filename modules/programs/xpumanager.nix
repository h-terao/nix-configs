{
  delib,
  pkgs,
  ...
}:
let
  # Not in nixpkgs, so built from packages/xpumanager.
  package = pkgs.callPackage ../../packages/xpumanager { };
in
delib.module {
  name = "programs.xpumanager";
  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    # xpu-smi talks to the GPU through Level Zero sysman, so it needs the
    # graphics stack that hardware.graphics.intel sets up.
    environment.systemPackages = [ package ];
  };
}
