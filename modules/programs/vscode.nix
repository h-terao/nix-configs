{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "programs.vscode";
  options = delib.singleEnableOption true;

  nixos.always = {
    nixpkgs.overlays = [
      inputs.nix-vscode-extensions.overlays.default
    ];
  };

  # The extension list below reads pkgs.nix-vscode-extensions from the home
  # configuration, so the overlay has to be applied there as well.
  home.always = {
    nixpkgs.overlays = [
      inputs.nix-vscode-extensions.overlays.default
    ];
  };

  home.ifEnabled = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;

      argvSettings = {
        locale = "ja";
        enable-crash-reporter = true;
      };

      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        userSettings = {
          "extensions.autoUpdate" = false;
          "workbench.colorTheme" = "Ra Spring";
          "editor.fontFamily" = "'PlemolJP', 'NotoMono Nerd Font'";
          "editor.fontSize" = 18;
          "editor.formatOnSave" = true;
          "explorer.confirmDragAndDrop" = false;
          "github.copilot.enable" = {
            "*" = true;
            markdown = true;
            plaintext = false;
            scminput = false;
          };
          "github.copilot.nextEditSuggestions.enabled" = true;
        };
        extensions =
          (with pkgs.nix-vscode-extensions.vscode-marketplace; [
            # Language Pack
            ms-ceintl.vscode-language-pack-ja
            # Theme
            rahmanyerli.ra-spring
            # AI
            github.copilot
            anthropic.claude-code
            # Python
            ms-python.python
            # Deno
            denoland.vscode-deno
            # ms-python.vscode-pylance
            charliermarsh.ruff
            # Nix
            jnoortheen.nix-ide
          ])
          ++ (with pkgs.vscode-extensions; [
            ms-python.vscode-pylance
          ]);
        keybindings = [
          {
            key = "ctrl+space";
            command = "-editor.action.triggerSuggest";
            when = "editorHasCompletionItemProvider && textInputFocus && !editorReadonly && !suggestWidgetVisible";
          }
        ];
      };
    };
  };
}
