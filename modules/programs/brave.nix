{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.brave";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
    };
  };
}
