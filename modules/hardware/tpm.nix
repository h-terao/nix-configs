{
  delib,
  lib,
  ...
}:
delib.module {
  name = "hardware.tpm";
  options = delib.moduleOptions (
    with delib;
    {
      enable = boolOption false;
      luksDeviceName = allowNull (strOption null);
    }
  );

  nixos.ifEnabled =
    { cfg, ... }:
    {
      security.polkit.enable = true;

      # TPM2 configurations
      security.tpm2.enable = true;
      security.tpm2.pkcs11.enable = true;
      security.tpm2.tctiEnvironment.enable = true;

      # Enable TPM2 for initrd
      boot.initrd.systemd.enable = true;
      boot.initrd.systemd.tpm2.enable = true;
      boot.initrd.luks.devices = lib.optionalAttrs (cfg.luksDeviceName != null) {
        ${cfg.luksDeviceName}.crypttabExtraOpts = [
          "tpm2-device=auto"
        ];
      };
    };
}
