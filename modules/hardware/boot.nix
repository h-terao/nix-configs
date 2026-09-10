{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "hardware.boot";
  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
