{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.brave";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
    };
  };
}
