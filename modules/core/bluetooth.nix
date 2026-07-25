{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "core.bluetooth";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    # Enable bluetooth
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
