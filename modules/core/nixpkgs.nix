{
  delib,
  inputs,
  ...
}:
let
  pkgs-overlays = [
    # inputs.quickshell.overlays.default
    inputs.playwright-cli.overlays.default
  ];
in
delib.module {
  name = "core.nixpkgs";

  nixos.always = {
    nixpkgs = {
      config.allowUnfree = true;
      overlays = pkgs-overlays;
    };
  };

  home.always = {
    nixpkgs = {
      config.allowUnfree = true;
      overlays = pkgs-overlays;
    };
  };
}
