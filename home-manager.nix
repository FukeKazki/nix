{ ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.kazki = {
    home.stateVersion = "25.05";
    programs = {
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
      zsh.enable = true;
    };
  };
}
