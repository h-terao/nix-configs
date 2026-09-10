{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.docker";
  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    virtualisation.docker.enable = true;
  };

  darwin.ifEnabled = {
    virtualisation.docker.enable = true;
  };
}
