{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.docker";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    virtualisation.docker.enable = true;
  };

  darwin.ifEnabled = {
    virtualisation.docker.enable = true;
  };
}
