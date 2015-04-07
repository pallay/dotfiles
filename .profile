[ -z "$PS1" ] && return

export EDITOR='mate -w'
export SVN_EDITOR='mate -w'

export MAVEN_OPTS="-Xmx2G -XX:MaxPermSize=2G -XX:ReservedCodeCacheSize=1g"

#export CC="/usr/local/Cellar/gcc/4.9.1/bin/gcc-4.9"
#export CXX="/usr/local/Cellar/gcc/4.9.1/bin/g++-4.9"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/opt/X11/lib/pkgconfig
export CPPFLAGS="-I/usr/local/opt/libxml2/include"
export LDFLAGS="-L/usr/local/opt/libxml2/lib"

man () {
  /usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | mate)
}

# flow control
stty -ixon

source /Users/pallay/.rvm/scripts/rvm

alias copypath='pwd | tr -d "\r\n" | pbcopy'

alias l='ls -CSF'
alias la='ls -A'
alias ll='ls -lh'
alias ls='ls -hp'
alias back='cd $OLDPWD'
alias cd..='cd ..'
alias df='df -h'
alias du='du -h -c'
alias mkdir='mkdir -p -v'
alias ..='cd ..'
alias ps='ps -wAf'

alias grep='grep --color=auto'
alias gj='grep java'

alias g=git

alias psjava='ps -wAf | grep java'

alias ping='ping -c 5'
alias nano='nano -w'
alias more='less'

alias tails='tail -n1000 -f'

alias pgrep="pgrep -l"
alias recent="ls -lAt | head"
# alias Xdefaults="xrdb -load ~/.Xdefaults"

alias locate1='if [ $((`date +%s`-`eval $(stat -s /var/db/locate.database); echo $st_mtime`)) -gt 3600 ]; then echo "locate: db is too old!">/dev/stderr; sudo /usr/libexec/locate.updatedb; fi; locate -i'
alias stamp='touch -c -t'

# export CURRENT_PROJECT_PATH=$HOME/.current-project
# function chpwd {
#   echo $(pwd) >! $CURRENT_PROJECT_PATH
# }
# current() {
#   if [[ -f $CURRENT_PROJECT_PATH ]]; then
#     cd "$(cat $CURRENT_PROJECT_PATH)"
#   fi
# }
# current

alias find_it="find / $1 | grep $1"
alias su_find_it="sudo find / $1 | grep $1"
alias vacuum_mail="sqlite3 ~/Library/Mail/Envelope\ Index vacuum | echo 'done'"
alias iterm_speedup="sudo rm -rf /private/var/log/asl/*.asl"

alias nmap="sudo nmap -sP 192.168.1.0/24 | awk '/^Nmap/{ip=$NF}/B8:27:EB/{print ip}'"

# [[ -f ~/.autojump/etc/profile.d/autojump.bash ]] && source ~/.autojump/etc/profile.d/autojump.bash

HISTTIMEFORMAT="(%F %T) "

function setjdk() {  
  if [ $# -ne 0 ]; then
    removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'  
    if [ -n "${JAVA_HOME+x}" ]; then  
      removeFromPath $JAVA_HOME  
    fi  
    export JAVA_HOME=`/usr/libexec/java_home -v $@`  
    export PATH=$JAVA_HOME/bin:$PATH  
  fi  
  echo JAVA_HOME set to $JAVA_HOME  
  java -version  
}  
# --exec javac -version

function removeFromPath() {  
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")  
}

# functions
function loadbashcompl {
  local files=(
    "/etc/bash_completion"
    "/usr/local/etc/bash_completion"
    "/usr/share/bash-completion/bash_completion"
  )
  local loaded=0
  for f in "${files[@]}"; do
    if [ -f $f ]; then
        . $f
        loaded=1
    fi
  done
  if [ $loaded == 0 ]; then
    echo "No bash completion available"
  fi
}

function hr {
  printf -v line "%${COLUMNS}s" ""
  echo "${line// /=}"
}

function calc {
  echo "${@}" | bc -l
}

echo "Host: ${HOSTNAME}"
echo "Path: ${PWD}"

