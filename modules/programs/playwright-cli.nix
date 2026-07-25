{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.playwright-cli";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = [ pkgs.playwright-cli ];
  };
}
