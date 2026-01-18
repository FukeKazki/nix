{ pkgs, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.primaryUser = "kazki";
  nix.enable = false;
  users.users.kazki.home = "/Users/kazki";

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    taps = [
      "hudochenkov/sshpass"
      "koekeishiya/formulae"
      "ngrok/ngrok"
      "shopify/shopify"
      "stripe/stripe-cli"
      "xwmx/taps"
    ];
    brews = [
      "cmake"
      "cocoapods"
      "codex"
      "eza"
      "fzf"
      "gcc"
      "gh"
      "ghq"
      "gitui"
      "gnu-sed"
      "graphviz"
      "httpie"
      "httrack"
      "hudochenkov/sshpass/sshpass"
      "koekeishiya/formulae/yabai"
      "mise"
      "ncspot"
      "neovim"
      "ninja"
      "peco"
      "pipx"
      "qpdf"
      "scrcpy"
      "shopify/shopify/shopify-cli"
      "stripe/stripe-cli/stripe"
      "tmux"
      "tree"
      "uv"
      "wget"
      "xwmx/taps/nb"
      "yt-dlp"
    ];
    casks = [
      "android-platform-tools"
      "arc"
      "chatgpt"
      "discord"
      "figma"
      "ghostty"
      "google-chrome@canary"
      "karabiner-elements"
      "keycastr"
      "kiro"
      "ngrok"
      "notion-calendar"
      "orbstack"
      "pronotes"
      "raycast"
      "screen-studio"
      "slack"
      "spotify"
      "visual-studio-code"
    ];
  };

  # Finder: show hidden files
  system.defaults.finder.AppleShowAllFiles = true;
  # Finder: show path bar
  system.defaults.finder.ShowPathbar = true;

  # Required by nix-darwin for compatibility with module defaults.
  system.stateVersion = 5;
}
