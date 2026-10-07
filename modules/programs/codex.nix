{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "programs.codex";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.codex = {
      enable = true;
      package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codex;
    };

    home.file.".agents" = {
      source = ../../dotfiles/.agents;
      recursive = true;
    };

    home.file.".codex" = {
      source = "${../../dotfiles}/.codex";
      recursive = true;
    };
  };
}
