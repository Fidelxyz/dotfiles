# Use XDG dirs for completion and history files
[ -d "$XDG_STATE_HOME/zsh" ] || mkdir -p "$XDG_STATE_HOME/zsh"
HISTFILE="$XDG_STATE_HOME/zsh/history"
[ -d "$XDG_CACHE_HOME/zsh" ] || mkdir -p "$XDG_CACHE_HOME/zsh"
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache

# ========================================

[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# pnpm
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac

# ========================================

# Oh My Zsh
source "$ZDOTDIR/.ohmyzsh.zsh"

# Powerlevel10k
[[ -f "$ZDOTDIR/.p10k.zsh" ]] && source "$ZDOTDIR/.p10k.zsh"

# fzf
if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND="fd --type f --hidden --no-ignore-vcs --exclude .git"
    export FZF_CTRL_T_COMMAND="fd --type f --hidden --no-ignore-vcs --exclude .git"
    export FZF_ALT_C_COMMAND="fd --type d --hidden --no-ignore-vcs --exclude .git"
fi
(( $+commands[fzf] ))    && source <(fzf --zsh)
(( $+commands[jj] ))     && source <(COMPLETE=zsh jj)

(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

# ========================================

[[ -f "$ZDOTDIR/zshrc-local.zsh" ]] && source "$ZDOTDIR/zshrc-local.zsh"
[[ -f "$ZDOTDIR/secrets.zsh" ]]     && source "$ZDOTDIR/secrets.zsh"
