{
  delib,
  lib,
  ...
}:
delib.module {
  name = "profiles.base";
  options = delib.singleEnableOption true;

  myconfig.ifEnabled.programs = {
    bash.enable = lib.mkDefault true;
    fish.enable = lib.mkDefault true;

    bat.enable = lib.mkDefault true;
    eza.enable = lib.mkDefault true;
    jq.enable = lib.mkDefault true;
    ripgrep.enable = lib.mkDefault true;
    yazi.enable = lib.mkDefault true;
    zoxide.enable = lib.mkDefault true;

    git.enable = lib.mkDefault true;
    github-cli.enable = lib.mkDefault true;
  };
}
