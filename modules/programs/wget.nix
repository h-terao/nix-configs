{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.wget";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [ wget ];
  };
}
