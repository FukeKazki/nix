{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jujutsu
  ];
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "FukeKazki";
        email = "kazkichi0906@gmail.com";
      };
    };
  };
}
