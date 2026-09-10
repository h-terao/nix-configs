{
  delib,
  lib,
  ...
}:
delib.module {
  name = "profiles.wsl";
  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    hardware.wsl.enable = lib.mkDefault true;

    # The VS Code Server installer fetches its tarball with wget.
    programs.wget.enable = lib.mkDefault true;
  };
}
