{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.openssl";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [ openssl ];
  };
}
