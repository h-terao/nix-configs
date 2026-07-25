{
  delib,
  ...
}:
delib.module {
  name = "programs.jq";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.jq.enable = true;
  };
}
