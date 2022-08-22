# https://askubuntu.com/questions/829069/what-does-i-return-mean
# Make sure that it's running interactively
[[ $- != *i* ]] && return

# Change title of terminal
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*|alacritty)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

# Displays the terminals system colors
colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

### Archive extraction
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
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
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#xhost +local:root > /dev/null 2>&1

# Case-insensitive TAB completion
bind "set completion-ignore-case on"

### Shopt
shopt -s autocd  # A directory is executed as it were the argument to the cd command
shopt -s cdspell  # Corrects minor spelling errors in the cd command
shopt -s checkwinsize  # Checks terminal size after executing a command and adjust LINES and COLUMNS accordingly
shopt -s cmdhist  # Save all lines of a multi-line command in the same entry
shopt -s dotglob  # Include . files in when using *
shopt -s expand_aliases  # Expands aliases
shopt -s histappend  # Append to history, don't overwrite it

# Prefered options for common programs
alias df='df --total -h -T'
alias free='free -h'
alias nano='nano -E -S -i -l -q'
alias more=less
alias open=xdg-open

# Change ls for exa
alias ls='exa --color=always --group-directories-first -a --icons'
alias ll='exa --color=always --group-directories-first -a -l -h -G --icons'
alias lt='exa --color=always --group-directories-first -a -T --icons'

# Colorized grep
alias grep='grep --colour=always'
alias egrep='egrep --colour=always'
alias fgrep='fgrep --colour=always'

# Confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -I"

# dnf
alias update="sudo dnf update"
alias search="dnf search"
alias install="sudo dnf install"
alias remove="sudo dnf remove"

# Used for config-files repo
alias config='git --git-dir=$HOME/.files/ --work-tree=$HOME'

# University
alias rumad="ssh -oHostKeyAlgorithms=+ssh-rsa estudiante@rumad.uprm.edu"

# PATH
export PATH=/home/dvt/.local/bin:$PATH

## powerline-shell
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
##

neofetch
