{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "base.nix";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    nix = {
      settings = {
        auto-optimise-store = true;
        substituters = [
          "https://nix-community.cachix.org"
          "https://yukimuro.dev/cache/h-terao"
          "https://cache.numtide.com"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "yukimuro-h-terao-1:fpHnGMInbfIw+GhjKGHPVtsUDTtS+Krt4Hg6fgwi+5c="
          "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        ];
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
      };
    };

    # Boot options for resource optimization
    boot.loader.systemd-boot.configurationLimit = 5;
    boot.tmp.cleanOnBoot = true;

    # Install common pacckages.
    programs.nix-ld.enable = true;
    environment.systemPackages = with pkgs; [
      nixfmt
    ];
  };
}
