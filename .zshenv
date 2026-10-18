export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="/run/user/$UID"

# ==============================

# Zsh
export ZDOTDIR="$HOME/.config/zsh"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
# Bash
mkdir -p "$XDG_STATE_HOME/bash"
export HISTFILE="$XDG_STATE_HOME/bash/history"
# Rust
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
# Python
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"
# Node.js
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
# npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# nuget
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"
# wget
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
# Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
# xorg-xauth
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

# ==============================

export EDITOR="nvim"
export VISUAL="nvim"
