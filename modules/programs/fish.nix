{
  delib,
  ...
}:
delib.module {
  name = "programs.fish";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.fish = {
      enable = true;
    };
  };
}
