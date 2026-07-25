{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.github-cli";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.gh = {
      enable = true;
    };
  };
}
