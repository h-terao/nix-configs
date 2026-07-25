{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.mise";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.mise = {
      enable = true;
      enableFishIntegration = true;
      globalConfig.settings = {
        all_compile = false;
        paranoid = false;
      };
    };
  };
}
