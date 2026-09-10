{
  description = "Packaged @playwright/cli for Nix/NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    let
      mkPlaywrightCli =
        pkgs:
        let
          inherit (pkgs) lib;
          system = pkgs.stdenv.hostPlatform.system;
          throwSystem = throw "playwright-cli: unsupported system ${system}";
          playwrightDir = "${pkgs.path}/pkgs/development/web/playwright";

          # pkgs.playwright-driver.browsers is deliberately NOT used: it is pinned to the
          # playwright release in nixpkgs, which lags the playwright-core that
          # @playwright/cli vendors. The mismatch is not cosmetic -- webkit-2311 against
          # playwright-core 1.62 dies with
          #   Protocol error (Page.overrideSetting): Unknown setting: PushAPIEnabled
          # so the browser builds have to match what the CLI actually ships.
          #
          # These values come from the vendored
          #   node_modules/playwright-core/browsers.json
          # and must be refreshed whenever `version` is bumped. To get a hash, set it to
          # lib.fakeHash and read the "got:" line from the build failure.
          browserSpecs = {
            chromium = {
              revision = "1232";
              browserVersion = "151.0.7922.10";
              hash = "sha256-q7eQ0T20DNi7qsjnZjQo3HoC3QYRIHFPmOHLoah3lA4=";
            };
            chromium-headless-shell = {
              revision = "1232";
              browserVersion = "151.0.7922.10";
              hash = "sha256-EjS+lYIjjZvzMAMHCtdEbDGmmFHCFXdAuT2b76+HRwQ=";
            };
            firefox = {
              revision = "1534";
              hash = "sha256-TXMn4abtutyNGnYExee30qkRpLQxqRzPDFJx6aYthr0=";
            };
            webkit = {
              revision = "2327";
              hash = "sha256-XCCZscjk1o5d2rRDL4PMhgHIXuXJAUG1lQ8m8PmUGTc=";
              # webkit-2327 links against these; nixpkgs 26.05's webkit.nix was written
              # for an older build and omits them, so autoPatchelf fails on
              # libbacktrace.so.0 / libenchant-2.so.2. Already present on unstable, where
              # the extra entries are inert.
              extraBuildInputs = with pkgs; [
                libbacktrace
                enchant
              ];
            };
            ffmpeg = {
              revision = "1011";
              hash = "sha256-AWTiui+ccKHxsIaQSgc5gWCJT5gYwIWzAEqSuKgVqZU=";
            };
          };

          # nixpkgs' browser derivations already know how to unpack and autoPatchelf a
          # playwright build; they just hardcode the revision they were pinned to. Both
          # the revision and the download hash are plain arguments, so overriding
          # fetchzip is enough to retarget them at another revision.
          mkBrowser =
            name: spec:
            let
              drv = pkgs.callPackage "${playwrightDir}/${name}.nix" (
                {
                  inherit system throwSystem;
                  inherit (spec) revision;
                  fetchzip = args: pkgs.fetchzip (args // { inherit (spec) hash; });
                }
                // lib.optionalAttrs (spec ? browserVersion) { inherit (spec) browserVersion; }
                // lib.optionalAttrs (name == "chromium") {
                  fontconfig_file = pkgs.makeFontsConf { fontDirectories = [ ]; };
                }
              );
              extra = lib.optionals pkgs.stdenv.hostPlatform.isLinux (spec.extraBuildInputs or [ ]);
            in
            if extra == [ ] then
              drv
            else
              drv.overrideAttrs (old: {
                buildInputs = (old.buildInputs or [ ]) ++ extra;
              });

          # playwright resolves a browser to "<name with - replaced by _>-<revision>"
          # under PLAYWRIGHT_BROWSERS_PATH.
          browsers = pkgs.linkFarm "playwright-cli-browsers" (
            lib.mapAttrsToList (name: spec: {
              name = "${lib.replaceStrings [ "-" ] [ "_" ] name}-${spec.revision}";
              path = mkBrowser name spec;
            }) browserSpecs
          );
        in
        pkgs.buildNpmPackage rec {
          pname = "playwright-cli";
          version = "0.1.17";

          src = pkgs.fetchFromGitHub {
            owner = "microsoft";
            repo = "playwright-cli";
            rev = "v${version}";
            hash = "sha256-tc/2Qck3mm6BqWTu2lvvfsM0/BHO/Z0ZvCdFZ7QQqKI=";
          };
          npmDepsHash = "sha256-u44jWprmr3RdzB3aDL3K0ShT5lLxr175z3C8pN43YFA=";

          nativeBuildInputs = [ pkgs.makeWrapper ];
          env.PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";
          npmInstallFlags = [ "--ignore-scripts" ];
          dontNpmBuild = true;

          passthru = { inherit browsers browserSpecs; };

          # No PLAYWRIGHT_MCP_EXECUTABLE_PATH here: it overrides executablePath for
          # *every* browser, so pinning it to the chromium binary silently breaks
          # `--browser firefox` / `--browser webkit`. PLAYWRIGHT_MCP_BROWSER=chromium
          # instead makes the default resolve to the chrome-for-testing alias, which the
          # registry serves out of PLAYWRIGHT_BROWSERS_PATH; without it the CLI defaults
          # to channel "chrome" and demands a system Google Chrome install.
          postFixup = ''
            wrapProgram $out/bin/playwright-cli \
              --set PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD 1 \
              --set PLAYWRIGHT_BROWSERS_PATH ${browsers} \
              --set PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS true \
              --set PLAYWRIGHT_HOST_PLATFORM_OVERRIDE ubuntu-24.04 \
              --set-default PLAYWRIGHT_MCP_BROWSER chromium
          '';
        };
    in
    {
      overlays.default = final: prev: {
        playwright-cli = mkPlaywrightCli final;
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.playwright-cli = mkPlaywrightCli pkgs;
        packages.default = self.packages.${system}.playwright-cli;

        apps.default = flake-utils.lib.mkApp {
          drv = self.packages.${system}.playwright-cli;
          exePath = "/bin/playwright-cli";
        };
      }
    );
}
