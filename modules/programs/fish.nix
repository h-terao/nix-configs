{
  delib,
  ...
}:
delib.module {
  name = "programs.fish";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.fish = {
      enable = true;
    };
  };
}
