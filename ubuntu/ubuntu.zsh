LANG=C.UTF-8
XZ_OPT="-6eT0"
PATH="$HOME/.local/bin:$PATH"
FZF_DEFAULT_COMMAND="fd --type file --color=always --follow --hidden --exclude .git"
FZF_DEFAULT_OPTS="--ansi"
export  PATH LANG XZ_OPT \
    FZF_DEFAULT_COMMAND FZF_DEFAULT_OPTS
alias vi="nvim"
alias vim="nvim"


######## plugin starts
# install zinit if not found
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
# load zinit
source "$HOME/.zinit/bin/zinit.zsh"
# required by turbo mode plugins
zinit light-mode for \
  zinit-zsh/z-a-bin-gem-node \
  zinit-zsh/z-a-rust
# theme
zinit ice compile="(pure|async).zsh" pick="async.zsh" src="pure.zsh"
zinit light sindresorhus/pure
# completion + highlighting
zinit wait lucid for \
 atload="!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions
zinit wait lucid blockf atpull="zinit creinstall -q ." for \
  zsh-users/zsh-completions \
  pkulev/zsh-rustup-completion
# common tools
zinit wait lucid as=null from=gh-r for \
  sbin="*/rg" BurntSushi/ripgrep \
  sbin="*/fd" @sharkdp/fd \
  sbin="*/bat" @sharkdp/bat \
  sbin="*/exa" ogham/exa \
  sbin="* -> ffmpeg" bpick="$(uname -s)-x64" eugeneware/ffmpeg-static \
  sbin="src" sourcegraph/src-cli \
  id-as"fzf-bin" sbin"fzf" junegunn/fzf
# uitls
zinit wait lucid for \
  vtta/zsh-aliases-exa \
  ael-code/zsh-colored-man-pages \
  OMZP::git \
  multisrc"shell/{completion,key-bindings}.zsh" junegunn/fzf
  #Aloxaf/fzf-tab
# A little more complex rustup configuration that uses Bin-Gem-Node annex
# and installs the cargo completion provided with rustup, using for-syntax
zinit wait lucid id-as=rust as=null sbin="bin/*" rustup \
    atload="[[ ! -f ${ZINIT[COMPLETIONS_DIR]}/_cargo ]] && zi creinstall rust; \
    export CARGO_HOME=\$PWD RUSTUP_HOME=\$PWD/rustup; \
    export PATH=\$CARGO_HOME/bin:\$PATH" for \
        zdharma/null
# should be the last one to load
zinit wait=1 lucid for \
 atinit="ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting
######## plugin ends


######## histroy files
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
# History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data


######## SHORTCUTS
bindkey "^[[1;5D" backward-word # ctrl + arrow left
bindkey "^[[1;5C" forward-word # ctrl + arrow right
bindkey "^[[H" beginning-of-line # home
bindkey "^[[F" end-of-line # end

