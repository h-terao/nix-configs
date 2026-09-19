args@{
  config,
  inputs,
  lib,
  # Include pkgs in the arguments forwarded to the upstream modules.
  pkgs,
  ...
}:
let
  # Upstream has no enable option. Gate its config and imported profiles
  # (including qemu-guest), while keeping option declarations unconditional.
  withAvfEnable =
    module:
    let
      upstream = (if lib.isFunction module then module else import module) args;
    in
    {
      imports = map withAvfEnable (upstream.imports or [ ]);
      options = upstream.options or { };
      config = lib.mkIf config.avf.enable (
        upstream.config or (builtins.removeAttrs upstream [ "imports" ])
      );
    };
in
{
  imports = [ (withAvfEnable inputs.nixos-avf.nixosModules.avf) ];

  options = {
    avf.enable = lib.mkEnableOption "Android Virtualization Framework support";

    # Preserve upstream's conditions and settings, and any other kernel patches.
    boot.kernelPatches = lib.mkOption {
      apply = map (
        patch:
        if config.avf.enable && (patch.name or "") == "avf-ballon" then
          patch
          // {
            patch = pkgs.callPackage ./. { originalPatch = patch.patch; };
          }
        else
          patch
      );
    };
  };
}
