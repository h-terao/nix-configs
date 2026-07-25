{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.bat";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [ bat ];
    environment.shellAliases = {
      cat = "bat -p --paging=never";
    };
  };

  home.ifEnabled = {
    programs.bat.enable = true;
    # environment.shellAliases does not work well for fish shell,
    # so that directly set aliases here.
    programs.fish.shellAliases = {
      cat = "bat -p --paging=never";
    };
  };
}
