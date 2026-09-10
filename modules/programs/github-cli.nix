{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.github-cli";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.gh = {
      enable = true;
    };
  };
}
