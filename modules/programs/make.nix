{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.make";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [ pkgs.gnumake ];
  };
}
