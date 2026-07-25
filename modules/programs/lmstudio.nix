{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.lmstudio";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = [ pkgs.lmstudio ];
  };
}
