{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.dotenvx";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [ dotenvx ];
  };
}
