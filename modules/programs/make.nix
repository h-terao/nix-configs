{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.make";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = [ pkgs.gnumake ];
  };
}
