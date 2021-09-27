PKG_CONFIG_PATH="$HOME/.local/share/pkgconfig"
LD_LIBRARY_PATH="/opt/local/lib"
# LD_LIBRARY_PATH="/opt/local/lib:/opt/intel/oneapi/tbb/latest/lib/intel64/gcc4.8"
RUSTFLAGS="-L /opt/local/lib"
LANG=en_US.UTF-8
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8
XZ_OPT="-6eT0"
PATH="$HOME/.local/bin:/opt/local/bin:$PATH"
FZF_DEFAULT_COMMAND="fd --type file --color=always --follow --hidden --exclude .git"
FZF_DEFAULT_OPTS="--ansi"
export PATH \
  LANG LC_CTYPE LC_ALL \
  FZF_DEFAULT_COMMAND FZF_DEFAULT_OPTS \
  XZ_OPT \
  PKG_CONFIG_PATH LD_LIBRARY_PATH
alias vi="nvim"
alias vim="nvim"

######## plugin starts
# install zinit if not found
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" &&
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" ||
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
# load zinit
source "$HOME/.zinit/bin/zinit.zsh"
# required by turbo mode plugins
zinit light-mode for \
  zinit-zsh/z-a-bin-gem-node \
  zinit-zsh/z-a-rust \
  zinit-zsh/z-a-readurl
# theme
zinit light-mode for \
  compile="(pure|async).zsh" pick="async.zsh" src="pure.zsh" sindresorhus/pure
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
  sbin="marp" marp-team/marp-cli \
  sbin="*/rga*" phiresky/ripgrep-all \
  sbin="* -> ffmpeg" bpick="$(uname -s)-$(uname -m | sed s/x86_64/x64/g)" eugeneware/ffmpeg-static \
  sbin="* -> jq" stedolan/jq \
  sbin="src" sourcegraph/src-cli \
  id-as="fzf-bin" sbin="fzf" junegunn/fzf
# uitls
zinit wait lucid for \
  vtta/zsh-aliases-exa \
  ael-code/zsh-colored-man-pages \
  OMZP::git \
  multisrc"shell/{completion,key-bindings}.zsh" junegunn/fzf
#Aloxaf/fzf-tab
zinit id-as=zig as="readurl|program" extract \
  dlink="https://ziglang.org/builds/zig-$(uname -s | tr \[:upper:\] \[:lower:\] | sed s/darwin/macos/g)-x86_64-%VERSION%-dev.{10,20}.tar.xz" \
  sbin="*/zig" \
  for https://ziglang.org/download/
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
bindkey "^[[1;5D" backward-word  # ctrl + arrow left
bindkey "^[[1;5C" forward-word   # ctrl + arrow right
bindkey "^[[H" beginning-of-line # home
bindkey "^[[F" end-of-line       # end
