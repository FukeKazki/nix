{ lib, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.kazki = {
    home.stateVersion = "25.05";
    programs = {
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
      zsh = {
        enable = true;
        initContent = ''
          # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
          # Initialization code that may require console input (password prompts, [y/n]
          # confirmations, etc.) must go above this block; everything else may go below.
          if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
            source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
          fi

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
