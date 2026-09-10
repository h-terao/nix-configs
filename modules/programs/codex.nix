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
  };
}
