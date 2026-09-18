{
  delib,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  herdr = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.herdr;
in
delib.module {
  name = "programs.herdr";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [
      herdr
      pkgs.bash
      pkgs.git
      pkgs.jq
    ];

    home.activation.herdrWorktreeinclude =
      inputs.home-manager.lib.hm.dag.entryAfter [ "writeBoundary" ]
        ''
          run ${pkgs.writeShellScript "install-herdr-worktreeinclude" ''
            set -euo pipefail
            export PATH=${
              lib.makeBinPath [
                herdr
                pkgs.git
                pkgs.jq
              ]
            }:"$PATH"

            plugins=$(herdr plugin list --plugin tanshio.worktreeinclude --json)
            if ! jq -e '.result.plugins | length > 0' <<< "$plugins" > /dev/null; then
              herdr plugin install tanshio/herdr-worktreeinclude --yes
            elif ! jq -e '.result.plugins[0].enabled' <<< "$plugins" > /dev/null; then
              herdr plugin enable tanshio.worktreeinclude
            fi
          ''}
        '';
  };
}
