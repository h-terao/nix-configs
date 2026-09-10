{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.openssl";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [ openssl ];
  };
}
