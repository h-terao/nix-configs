{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.nodejs";
  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    environment.systemPackages = [ pkgs.nodejs ];
  };
}
