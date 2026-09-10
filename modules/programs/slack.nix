{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.slack";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      slack
    ];
  };
}
