{ ... }:
{
  xdg.configFile."zsh/prelude.zsh".text = ''
    # Disable instant prompt to avoid warnings about console output.
    export DIRENV_LOG_FORMAT=""
    typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
  '';
  xdg.configFile."zsh/completion.zsh".text = ''
    # 補完で大文字にもマッチ
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
  '';
  xdg.configFile."zsh/peco.zsh".text = ''
    #  ╭──────────────────────────────────────────────────────────╮
    #  │             tmuxのウィンドウをpecoで選択する             │
    #  ╰──────────────────────────────────────────────────────────╯
    # function peco-select-tmux-window() {
    #   local window=$(tmux list-windows -a -F '#I:#W' | peco --query "$LBUFFER")
    #   # window -> 2:playground
    #   # window%%:* -> 2
    #   if [ -n "$window" ]; then
    #       BUFFER="tmux select-window -t ''${window%%:*}"
    #       zle accept-line
    #   fi
    #    zle clear-screen
    # }
    # zle -N peco-select-tmux-window
    # bindkey '^W' peco-select-tmux-window

    function peco-select-article() {
      local articles=$(curl -s 'https://ingihstbdzbaxgaiznez.supabase.co/rest/v1/articles' \
      -H "apikey: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImluZ2loc3RiZHpiYXhnYWl6bmV6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk2OTUwNzksImV4cCI6MjAxNTI3MTA3OX0.ab2zn6aJGzv3I_pp5exGPhodUqxC5C1GJstp00l7_Lg" \
      -H "Content-Type: application/json")
      local article=$(echo $articles | jq -r '.[] | .title' | peco --query "$LBUFFER")
      if [ -n "$article" ]; then
          local selected_article=$(echo $articles | jq -r ".[] | select(.title == \"''${article}\") | .url")
          BUFFER="open ''${selected_article}"
          zle accept-line
      fi
       zle clear-screen
    }
    zle -N peco-select-article
    bindkey '^U' peco-select-article
  '';
  xdg.configFile."zsh/fzf.zsh".text = ''
    # fzf
    # brew install fzf
    export FZF_DEFAULT_OPTS=" \
    --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
    --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
    --color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
    --color=selected-bg:#51576d \
    --multi"
    source <(fzf --zsh)

    function fzf-cd-ghq () {
      local selected_dir=$(ghq list -p | fzf --query "$LBUFFER")
      if [ -n "$selected_dir" ]; then
        # ディレクトリ名を取得
        local dir_name=$(basename "$selected_dir")
        # ディレクトリに移動 & ウィンドウ名を変更
        BUFFER="cd ''${selected_dir} && tmux renamew ''${dir_name}"
        zle accept-line
      fi
      zle clear-screen
    }
    zle -N fzf-cd-ghq
    bindkey '^G' fzf-cd-ghq

    #  ╭──────────────────────────────────────────────────────────╮
    #  │     gitのブランチをfzfで選択してチェックアウトする       │
    #  ╰──────────────────────────────────────────────────────────╯
    function fzf-select-git-branch() {
        # git branch のリストを fzf で選択
        local branch=$(git branch -a | sed -r "s/^[ \*]+//; s#remotes/[^/]+/##" | fzf --query "$LBUFFER")
        if [ -n "$branch" ]; then
            BUFFER="git checkout ''${branch}"
            zle accept-line
        fi
        zle clear-screen
    }

    zle -N fzf-select-git-branch
    bindkey '^E' fzf-select-git-branch


    #  ╭──────────────────────────────────────────────────────────╮
    #  │     zの履歴からディレクトリ移動する                      │
    #  ╰──────────────────────────────────────────────────────────╯
    fzf-z-search() {
        local res=$(z | sort -rn | cut -c 12- | fzf)
        if [ -n "$res" ]; then
            BUFFER+="cd $res"
            zle accept-line
        else
            return 1
        fi
    }

    zle -N fzf-z-search
    bindkey '^Z' fzf-z-search
  '';
  xdg.configFile."zsh/mise.zsh".text = ''
    # mise
    eval "$(mise activate zsh)"
  '';
  xdg.configFile."zsh/android.zsh".text = ''
    # Android
    export ANDROID_HOME=$HOME/Library/Android/sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/tools
    export PATH=$PATH:$ANDROID_HOME/tools/bin
    export PATH=$PATH:$ANDROID_HOME/platform-tools
  '';
  xdg.configFile."zsh/bindings.zsh".text = ''
    bindkey '^A' autosuggest-accept
  '';
  xdg.configFile."zsh/env.zsh".text = ''
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

    [[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
  '';
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      pip = "pip3";
      t = "task";
      m = "memo";
      sed = "gsed";
      awk = "gawk";
      gcom = "git commit";
      ls = "eza";
      cd = "z";
      c = "clear";
      v = "nvim";
      gs = "git status";
      vv = "NVIM_APPNAME=nvim-term nvim";
      pn = "pnpm";
      tigp = "tig --first-parent -m";
      gitui = "gitui -t ~/.config/gitui/themes/catppuccin-frappe.ron";
      diff = "npx difit .";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-completions"; }
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zplug/zplug"; tags = [ "hook-build:'zplug --self-manage'" ]; }
        { name = "romkatv/powerlevel10k"; tags = [ "as:theme" "depth:1" ]; }
        { name = "rupa/z"; tags = [ "use:z.sh" ]; }
      ];
    };
    initContent = ''
      source "$HOME/.config/zsh/prelude.zsh"
      source "$HOME/.config/zsh/completion.zsh"
      setopt automenu
      setopt autocd
      setopt autopushd
      setopt share_history
      setopt inc_append_history
      setopt autoremoveslash
      source "$HOME/.config/zsh/peco.zsh"
      source "$HOME/.config/zsh/fzf.zsh"
      source "$HOME/.config/zsh/mise.zsh"
      source "$HOME/.config/zsh/android.zsh"
      source "$HOME/.config/zsh/bindings.zsh"
      source "$HOME/.config/zsh/env.zsh"
    '';
  };
}
