{
  delib,
  ...
}:
delib.module {
  name = "programs.yazi";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      shellWrapperName = "y";
    };
  };
}
