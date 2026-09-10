{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "hardware.bluetooth";
  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    # Enable bluetooth
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
