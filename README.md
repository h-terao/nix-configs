# My Nix Configs

- [Flakes](https://wiki.nixos.org/wiki/Flakes)
- [Denix](https://github.com/yunfachi/denix)

## Commands

```bash
# Update Nix channels
sudo nix flake update

# Apply new configuration to the system
sudo nixos-rebuild switch --flake .#<hostname>
sudo nixos-rebuild switch --flake .#hippo  # "hippo" hostname example
```

For the 1st time rebuilding the system with flakes, you may need to specify substituters explicitly:

```bash
sudo nixos-rebuild switch \
  --option extra-substituters 'https://cache.nixos.org/ https://nix-community.cachix.org https://yukimuro.dev/cache/h-terao https://cache.numtide.com' \
  --option extra-trusted-public-keys 'nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= yukimuro-h-terao-1:fpHnGMInbfIw+GhjKGHPVtsUDTtS+Krt4Hg6fgwi+5c= niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=' \
  --flake .#<hostname>
```
