{ ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.kazki = {
    imports = [
      ./hm/base.nix
      ./hm/direnv.nix
      ./hm/zsh.nix
      ./hm/aerospace.nix
    ];
  };
}
