{ lib, pkgs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.kazki = {
    home.stateVersion = "25.05";
    home.packages = with pkgs; [
      jujutsu
    ];
    programs = {
      jujutsu = {
        enable = true;
        settings = {
          user = {
            name = "FukeKazki";
            email = "kazkichi0906@gmail.com";
          };
        };
      };
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
      zsh = {
        enable = true;
        initContent = ''
          # Disable instant prompt to avoid warnings about console output.
          export DIRENV_LOG_FORMAT=""
          typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

          source ~/.zplug/init.zsh

          # 補完機能を有効にする
          autoload -Uz compinit
          compinit -u

          # 便利なzshオプションを有効化
          # 自動で補完候補を表示（Tabを押さなくても候補が見える）
          setopt automenu
          # ディレクトリ名だけでcdできる（cdコマンド不要）
          setopt autocd
          # cdするたびにディレクトリスタックに追加（popdで戻れる）
          setopt autopushd
          # 複数のターミナルセッション間で履歴を共有
          setopt share_history
          # 履歴を即座に追加（share_historyと組み合わせて使用）
          setopt inc_append_history
          # 補完時に最後のスラッシュを自動削除
          setopt autoremoveslash

          # 補完で大文字にもマッチ
          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

          source ~/zsh/aliases.zsh
          source ~/zsh/peco.zsh
          source ~/zsh/fzf.zsh
          source ~/zsh/mise.zsh
          source ~/zsh/android.zsh
          source ~/zsh/autosuggestions.zsh
          source ~/zsh/plugins.zsh
          # scripts
          export PATH="$HOME/zsh/scripts:$PATH"
          export PATH=$PATH:/Users/kazki/.local/bin

          export COLORTERM=truecolor

          # The next line updates PATH for the Google Cloud SDK.
          if [ -f '/Users/kazki/Develop/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kazki/Develop/google-cloud-sdk/path.zsh.inc'; fi

          # The next line enables shell command completion for gcloud.
          if [ -f '/Users/kazki/Develop/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kazki/Develop/google-cloud-sdk/completion.zsh.inc'; fi


          # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
          [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

          # Then, source plugins and add commands to $PATH
          zplug load

          [[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
        '';
      };
    };
  };
}
