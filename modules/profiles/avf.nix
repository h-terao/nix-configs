{
  delib,
  lib,
  ...
}:
delib.module {
  name = "profiles.avf";
  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    hardware.avf.enable = lib.mkDefault true;
  };
}
