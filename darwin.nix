{ pkgs, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.primaryUser = "kazki";
  nix.enable = false;
  users.users.kazki.home = "/Users/kazki";

  # Finder: show hidden files
  system.defaults.finder.AppleShowAllFiles = true;

  # Required by nix-darwin for compatibility with module defaults.
  system.stateVersion = 5;
}
