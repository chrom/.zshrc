# Midnight Commander subshell integration (must be before p10k instant prompt)
if [[ -n "$MC_SID" ]]; then
  export POWERLEVEL9K_INSTANT_PROMPT=off
fi
# Source mc shell integration if available
for _mc_file in \
  /usr/share/mc/mc.zsh \
  /usr/share/mc/shell/mc.zsh \
  /usr/libexec/mc/mc.zsh \
  /usr/share/mc/mc.sh; do
  [[ -r "$_mc_file" ]] && source "$_mc_file" && break
done
# CLI enhancements (conditional aliases)
# ls via eza/exa
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first --icons=auto'
  alias ll='eza -l --group-directories-first --icons=auto'
  alias la='eza -la --group-directories-first --icons=auto'
elif command -v exa >/dev/null 2>&1; then
  alias ls='exa --group-directories-first --icons=auto'
  alias ll='exa -l --group-directories-first --icons=auto'
  alias la='exa -la --group-directories-first --icons=auto'
fi

# fd on Ubuntu is fdfind
if command -v fdfind >/dev/null 2>&1; then
  alias fd='fdfind'
fi

# bat/batcat for pretty cat and man pager
if command -v bat >/dev/null 2>&1; then
  alias ccat='bat -pp'
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
elif command -v batcat >/dev/null 2>&1; then
  alias bat='batcat'
  alias ccat='batcat -pp'
  export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
fi

# ripgrep helpers (do not override grep by default)
if command -v rg >/dev/null 2>&1; then
  alias rga='rg -n --color=auto'
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Keep PATH entries unique (affects both array and scalar forms)
typeset -U path PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/ratio/.oh-my-zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  jhipster
  docker
  docker-compose
  npm
  node
  pip
  pipenv
  poetry
  python
  pyenv
  rust
  zsh-cargo-completion
  gpg-agent
  ssh-agent
  ssh
  zsh-autosuggestions
  zsh-autocomplete
  zsh-navigation-tools
  zsh-interactive-cd
  fzf
  tmux
  vagrant
  toolbox
  systemd
  screen
  history
  gnu-utils
  aliases
  copyfile
  copypath
  urltools
  aws
  ansible
  composer
  github
  ubuntu
  lxd
  jhipster
  nmap
  zsh-ssh
)

# Speed up and stabilize completion cache
ZSH_COMPDUMP="$HOME/.zcompdump-$ZSH_VERSION"
zstyle ':completion:*' rehash true
autoload -Uz compinit && compinit -C

source $ZSH/oh-my-zsh.sh
# fzf keybindings + completion (load if available)
for f in \
  /usr/share/fzf/key-bindings.zsh \
  /usr/share/fzf/completion.zsh \
  "$HOME/.fzf/shell/key-bindings.zsh" \
  "$HOME/.fzf/shell/completion.zsh"
do
  [ -f "$f" ] && source "$f"
done
# Bindkey '^X' create_completion
# bindkey '^R' history-incremental-search-backward
# User configuration

# History settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt append_history           # append instead of overwrite
setopt inc_append_history       # write immediately
setopt extended_history         # timestamps and durations

setopt hist_ignore_space        # skip commands starting with space
setopt hist_reduce_blanks       # squeeze extra spaces
setopt hist_ignore_dups         # no adjacent duplicates
setopt hist_save_no_dups        # remove dups on save
setopt hist_find_no_dups        # ignore dups in search
setopt hist_expire_dups_first   # expire dups first
setopt hist_verify              # confirm history expansions

HIST_STAMPS="yyyy-mm-dd"

# Convenient reverse search
bindkey '^R' history-incremental-search-backward

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"




export GPGKEY=917B295CE6C4A16C
if [ -t 0 ]; then
  stty icrnl
fi
export GPG_TTY=$(tty)

# Google Cloud SDK handled in ~/.zprofile

# BEGIN SNIPPET: Magento Cloud CLI configuration (moved to ~/.zprofile)
HOME=${HOME:-'/home/ratio'}
export PATH="$HOME/go/bin:$PATH"
if [ -f "$HOME/"'.magento-cloud/shell-config.rc' ]; then . "$HOME/"'.magento-cloud/shell-config.rc'; fi # END SNIPPET


### NodeJS User configuration (moved to ~/.zprofile)


# Lazy-load NVM on first use
export NVM_DIR="$HOME/.nvm"
load_nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}
nvm()      { unset -f nvm node npm npx corepack; load_nvm; nvm "$@"; }
node()     { unset -f nvm node npm npx corepack; load_nvm; node "$@"; }
npm()      { unset -f nvm node npm npx corepack; load_nvm; npm "$@"; }
npx()      { unset -f nvm node npm npx corepack; load_nvm; npx "$@"; }
corepack() { unset -f nvm node npm npx corepack; load_nvm; corepack "$@"; }

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/ratio/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/ratio/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/ratio/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/ratio/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<





autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
# eval "$(bw completion --shell zsh); compdef _bw bw;"

#yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
 # Load user secrets if present (600 perms recommended)
if [ -f "$HOME/.zsh_secrets" ]; then
  source "$HOME/.zsh_secrets"
fi
if [ -f "$HOME/.local/share/intelli-shell/bin/intelli-shell.sh" ]; then
  source "$HOME/.local/share/intelli-shell/bin/intelli-shell.sh"
fi

if [ -f "/home/ratio/.config/broot/launcher/zsh/br" ]; then
  source "/home/ratio/.config/broot/launcher/zsh/br"
elif [ -f "/home/ratio/.config/broot/launcher/bash/br" ]; then
  source "/home/ratio/.config/broot/launcher/bash/br"
fi
export PATH="$HOME/.symfony5/bin:$PATH"

# SDKMAN lazy-load
export SDKMAN_DIR="${SDKMAN_DIR:-$HOME/.sdkman}"
load_sdkman() { [ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"; }
sdk() { unset -f sdk; load_sdkman; sdk "$@"; }

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
if [ -f "$HOME/export-esp.sh" ]; then
  . "$HOME/export-esp.sh"
fi
export PATH=$PATH:/home/ratio/Public/sonar-scanner/bin

export CARGO_HOME="$HOME/.cargo"
export CARGO_INSTALL_ROOT="$HOME/.cargo"


# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Initialize zoxide once


# Initialize zoxide once
 eval "$(zoxide init zsh)"

# direnv (per-project envs)
# Quick usage:
# 1) In project root create `.envrc`, e.g.:
#      export FOO=bar
#    Optional helpers: `dotenv`, `layout python`, `layout node`
# 2) Trust once per project: `direnv allow`
# 3) On cd into/out of the dir, vars load/unload automatically
# 4) Edit and reload: `direnv reload`
# 5) Revoke trust: `direnv deny`
# 6) Temporarily disable/enable: `direnv disable` / `direnv enable zsh`
# Security: `.envrc` is executable code — always review before `allow`.
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi
