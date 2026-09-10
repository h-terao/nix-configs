{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.playwright-cli";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [ pkgs.playwright-cli ];
  };
}
