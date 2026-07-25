{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.dotenvx";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [ dotenvx ];
  };
}
