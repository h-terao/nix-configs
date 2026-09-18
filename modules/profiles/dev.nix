{
  delib,
  lib,
  ...
}:
delib.module {
  name = "profiles.dev";
  options = delib.singleEnableOption false;

  myconfig.ifEnabled.programs = {
    playwright-cli.enable = lib.mkDefault true;

    make.enable = lib.mkDefault true;

    claude-code.enable = lib.mkDefault true;
    codex.enable = lib.mkDefault true;

    docker.enable = lib.mkDefault true;
    herdr.enable = lib.mkDefault true;
    openssl.enable = lib.mkDefault true;
    direnv.enable = lib.mkDefault true;
  };
}
