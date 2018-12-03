# ----------------------------------------------------------------------------
#
# Description: Generic Bashrc, source any additional tools here
#
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Environment Configuration
# ----------------------------------------------------------------------------
path=
path=$path:/bin
path=$path:/sbin
path=$path:/usr/bin
path=$path:/usr/sbin
path=$path:/usr/local/bin
path=$path:/etc
path=$path:/usr/etc

export PATH=$path
export EDITOR=gvim
export SCRIPTS=~/scripts

# ----------------------------------------------------------------------------
# Terminal Configuration
# ----------------------------------------------------------------------------

#if [ "$TERM" == "xterm-color" ]; then 
#  PROMPT_COMMAND='echo -ne "\033]2;${PWD##*/}\007\033]1;\007"' 
#fi
export PROMPT_COMMAND='history -a' #Appends ALL terminal changes

PS1='[\w]$ ' # Emultates cshell ant tells you your current path
#PS1='\[\033]0;$P4CLIENT\007\][\w]$ '
stty erase '^?'
ulimit -c unlimited
shopt -s nocaseglob # Allows auto completing ignoring case
shopt -s checkwinsize
shopt -s dotglob # Any search that includes a * will also include hidden files
set history = 1000
#stty -ixon

# ----------------------------------------------------------------------------
# Shortcuts
# ----------------------------------------------------------------------------

alias cp='cp -iv'
alias mv='mv -iv'
alias ls="/bin/ls -F --color=auto"
alias la='ls -F -a'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias lsd='/bin/ls -d --color */ 2>/dev/null'
alias grep='grep --color'
alias ..='cd ../'
alias 2.='cd ../../ '
alias 3.='cd ../../../ '
alias 4.='cd ../../../../ '
alias 5.='cd ../../../../../ '
alias 6.='cd ../../../../../../ '
alias path='echo ${PATH}'
alias mk='make -j16 2>&1 | tee make.txt'

function cd() { builtin cd "$@" && lsd; }

function ff() { /usr/bin/find ! -name "*.o" ! -name "*.d" -iname '*'"$@"'*'; }
function fh() { /usr/bin/find -maxdepth 1 ! -name "*.o" ! -name "*.d" -iname '*'"$@"'*'; }

function gf() { grep -isIunr --exclude-dir=*obsolete* --exclude=*.d --exclude=.tags "$@" .; }
function gc() { grep -sIunr  --exclude-dir=*obsolete* --exclude=*.d --exclude=.tags "$@" .; }
function gh() { grep -isIun  --exclude-dir=*obsolete* --exclude=*.d --exclude=.tags "$@" *; }

# ----------------------------------------------------------------------------
# Tools
# ----------------------------------------------------------------------------

function csource
{
  if [ -f $1 ]; then
    source $1
  fi
}

# Find local runable and execute it
function r() 
{ 
  local runScript="./run.sh"
  if [[ -x "$1" ]]; then
    ./$@;
  elif [ -f "${runScript}" ]; then
    "./${runScript}" $@;
  else 
    echo "Runnable not defined";
  fi
}

# Determines if the item selected is a ui. If it isn't opens it up with the editor selected
function e() 
{
  if [[ "$@" == *.ui ]]; then
    designer "${@}" &disown; 
  else
    if [[ $EDITOR -eq "gvim" ]]; then
      $EDITOR -p "${@}" &disown; 
    elif [[ $EDITOR -ne "vim" ]]; then
      $EDITOR "${@}" &disown; 
    else
      $EDITOR  "${@}"
    fi
  fi
}

function er()
{
  if [[ ($EDITOR -eq "gvim") && $# -eq 2 ]]; then
    $EDITOR --servername $1 --remote-tab-silent $2
  else
    echo "No remote handler for editor: $EDITOR"
  fi
}

function t()
{
  color="green"
  if [[ $1 == "r" ]]; then 
    color="orange"
    title="Runner"
  elif [[ $1 == "l" ]]; then 
    color="cyan"
    title="Log"
  elif [[ $1 == "s" ]]; then 
    color="white"
    title="Search"
  fi
  title+=" ${P4CLIENT}"
  xterm -fg $color -bg black -title "${title}" & disown;
}

export -f e
alias ev='e ~/.vimrc'
alias ep='e ~/.bashrc'
alias rp='. ~/.bashrc && echo "Bash Has Been Updated"'

# ----------------------------------------------------------------------------
# Environment specific sourcing
# ----------------------------------------------------------------------------
sys="$(uname -s)"
if [[ $sys == "Linux*" ]]; then
  csource "$SCRIPTS/.bashrc.accuray"
elif [[ $sys == "CYGWIN"* ]]; then
  csource "$SCRIPTS/cygwin.bashrc.sh"
fi
