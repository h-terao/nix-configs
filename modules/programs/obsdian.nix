{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.obsidian";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    # Avoid `programs.obsidian` to open last used vault on startup
    # https://github.com/nix-community/home-manager/issues/7406
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
