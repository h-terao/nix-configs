{
  delib,
  ...
}:
delib.module {
  name = "programs.zoxide";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };
}
