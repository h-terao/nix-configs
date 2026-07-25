{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "core.boot";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
