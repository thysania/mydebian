# ╔═╗╔═╗╦ ╦╦═╗╔═╗  ╔═╗╔═╗╔╗╔╔═╗╦╔═╗  - thysania
# ╔═╝╚═╗╠═╣╠╦╝║    ║  ║ ║║║║╠╣ ║║ ╦  - https://github.com/thysania/mydebian
# ╚═╝╚═╝╩ ╩╩╚═╚═╝  ╚═╝╚═╝╝╚╝╚  ╩╚═╝  - zsh config

### THE PROMPT
function dir_icon {
  if [[ "$PWD" == "$HOME" ]]; then
    echo "%B%F{black}%f%b"
  else
    echo "%B%F{cyan}%f%b"
  fi
}

PS1='%B%F{blue}%f%b  %B%F{magenta}%n%f%b $(dir_icon)  %B%F{red}%~%f%b${vcs_info_msg_0_} %(?.%B%F{green}.%F{red})%f%b '

### HISTORY
export EDITOR='nvim'
export TERMINAL='alacritty'
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

### LOADING ENGINE
autoload -Uz compinit

for dump in ~/.config/zsh/zcompdump(N.mh+24); do
  compinit -d ~/.config/zsh/zcompdump
done

compinit -C -d ~/.config/zsh/zcompdump

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
precmd () { vcs_info }
_comp_options+=(globdots)

zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'

### WAITING DOTS
expand-or-complete-with-dots() {
  echo -n "\e[31m…\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

### HISTORY
HISTFILE=~/.config/zsh/zhistory
HISTSIZE=5000
SAVEHIST=5000

### ZSH COOL OPTIONS
setopt AUTOCD                # change directory just by typing its name
setopt PROMPT_SUBST          # enable command substitution in prompt
setopt LIST_PACKED		       # The completion menu takes less space.
setopt AUTO_LIST             # Automatically list choices on ambiguous completion.
setopt HIST_IGNORE_DUPS	     # Do not write events to history that are duplicates of previous events
setopt HIST_FIND_NO_DUPS     # When searching history don't display results already cycled through twice

### PLUGINS
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

### ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

### ALIASES ###
alias mirrors="sudo reflector --verbose --latest 5 --country 'United States' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias lss='ls -la'

# screenshot
alias ss0='scrot -u -d ~/Pictures/Screenshots/Screenshot-%d%b%4Y-%a-%H-%M-%S.png'
alias ss2='scrot -u -d 2 ~/Pictures/Screenshots/Screenshot-%d%b%4Y-%a-%H-%M-%S.png'
alias ss5='scrot -u -d 5 ~/Pictures/Screenshots/Screenshot-%d%b%4Y-%a-%H-%M-%S.png'
alias ss9='scrot -u -d 9 ~/Pictures/Screenshots/Screenshot-%d%b%4Y-%a-%H-%M-%S.png'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# git
alias gitc='git clone'
alias gitcom='git commit -m'
alias gitp='git push'
alias gita='git add'

# shutdown and reboot
alias ssn='sudo shutdown'
alias sr='sudo reboot'

# pacman 
alias apts='sudo apt-get install'                         # Install pkgs
alias apty='sudo apt-get update'                          # Refresh pkglist
alias aptup='sudo apt-get update && sudo apt-get upgrade' # Refresh pkglist and update 
alias aptr='sudo apt-get remove'                          # Remove pkgs
alias aptrr='sudo apt-get remove --purge'                 # Purge

# others
alias zshrc='nvim ~/.zshrc'
alias bashrc='nvim ~/.bashrc'
alias vi="nvim"

### AUTOSTART
$HOME/.local/bin/colorscript --exec blocks1
