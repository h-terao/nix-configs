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

    mise.enable = lib.mkDefault true;
    make.enable = lib.mkDefault true;
    python.enable = lib.mkDefault true;
    nodejs.enable = lib.mkDefault true;

    claude-code.enable = lib.mkDefault true;
    codex.enable = lib.mkDefault true;

    docker.enable = lib.mkDefault true;
    herdr.enable = lib.mkDefault true;
    dotenvx.enable = lib.mkDefault true;
    openssl.enable = lib.mkDefault true;
  };
}
