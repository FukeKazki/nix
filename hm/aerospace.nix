{ pkgs, ... }:
{
  home.packages = with pkgs; [
    aerospace
  ];

  home.file.".aerospace.toml".source = ./../config/aerospace.toml;
}
