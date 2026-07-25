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