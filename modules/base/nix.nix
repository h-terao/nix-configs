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
          "https://h-terao.cachix.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "h-terao.cachix.org-1:3mC8vZI9jGSrC+QGZQk998D7KG+NYfo2ODCdnGXtNfs="
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
