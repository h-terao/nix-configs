{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.eza";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [ eza ];
    environment.shellAliases = {
      ls = "eza --icons --group-directories-first";
      ll = "eza -l --icons --group-directories-first";
      tree = "eza --tree --icons";
    };
  };

  home.ifEnabled = {
    programs.eza = {
      enable = true;
      enableFishIntegration = true;
    };

    # environment.shellAliases does not work well for fish shell,
    # so that directly set aliases here.
    programs.fish.shellAliases = {
      ls = "eza --icons --group-directories-first";
      ll = "eza -l --icons --group-directories-first";
      tree = "eza --tree --icons";
    };
  };
}
