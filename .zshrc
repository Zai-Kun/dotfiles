# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Exports
export EDITOR=nvim
export ZSH="$HOME/.oh-my-zsh"
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=$PATH:~/.modular/pkg/packages.modular.com_mojo/bin
export GTK_THEME=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")
export PATH=~/.koyeb/bin:$PATH
export PATH=~/.cargo/bin:$PATH
export LD_LIBRARY_PATH=~/.local/lib/arch-mojo:$LD_LIBRARY_PATH

# Aliases
alias rc_whipe='~/assets/bins/rustyclip clear'
alias pyenv_init='eval "$(pyenv init -)"'
alias cd="z"
alias qmount="sudo mount -o uid=$(id -u $(logname)),gid=$(id -g $(logname))"
alias copy="rsync -ah --partial --info=PROGRESS2"
alias wu="wg-quick up nl"
alias wd="wg-quick down nl"
alias spotube="MESA_GL_VERSION_OVERRIDE=4.3 spotube"
alias libre="librewolf"
alias rebot="sleep 4 && reboot"

# Zsh and zsh plugins related
ZSH_THEME="powerlevel10k/powerlevel10k" # Set name of the theme to load --- if set to "random", it will
ZSH_CUSTOM="$HOME/assets/omz-custom"
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)
source ~/assets/omz-custom/.zsh_files/catppuccin_mocha-zsh-syntax-highlighting.zsh
source $ZSH/oh-my-zsh.sh

# Uncomment the following lines to customize behavior
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
# zstyle ':omz:update' frequency 13
# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# export LANG=en_US.UTF-8
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Additional configurations
eval "$(zoxide init zsh)"
source "$HOME/.local/bin/env"

. "$HOME/.limbo/env"
