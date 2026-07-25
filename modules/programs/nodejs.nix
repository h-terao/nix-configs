{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.nodejs";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = [ pkgs.nodejs ];
  };
}
