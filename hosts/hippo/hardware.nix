{
  delib,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
delib.host {
  name = "hippo";

  system = "x86_64-linux";

  useHomeManagerModule = true;
  home.home.stateVersion = "25.11";

  # If you're not using NixOS, you can remove this entire block.
  nixos = {
    system.stateVersion = "25.11";

    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "thunderbolt"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/mapper/luks-e928bd5d-c0e5-4138-bb18-1e8d70b143c2";
      fsType = "ext4";
    };

    boot.initrd.luks.devices."luks-e928bd5d-c0e5-4138-bb18-1e8d70b143c2".device =
      "/dev/disk/by-uuid/e928bd5d-c0e5-4138-bb18-1e8d70b143c2";

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/835C-7E10";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
