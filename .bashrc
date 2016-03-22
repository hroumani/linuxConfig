PS1="\[\033]0;\h\007\]\[\033[1;32m\][\@]\[\033[0m\]\[\033[1;33m\][\u@\h]\$(pwd)\[\033[0m\] > "
alias ls='ls --classify --color=tty' 2>/dev/null
alias grep='grep 2>/dev/null'

function ll
{
	dir=0
	if [ $# -eq 0 ] ; then
		dir=0
	elif [ $# -eq 1 ] ; then
		first=$1
   	pos=${first:0:1};
   	if [ $pos == '-' ] ; then
			dir=0;
   	else
			dir=1
  	 	fi
	else
		dir=1
	fi

	if [ $dir -eq 0 ] ; then
		ls --classify --color=tty $* 2>/dev/null
	else
		ls --classify --color=tty -d $* 2>/dev/null
	fi
}

			
			
			
			


tty -s
if [ $? -eq 0 ] ; then
   DoInteractive=0
else
   DoInteractive=1
fi

# Can generate POD docs for this file by exectuting:
#../bin/shdoc file=kshrci

## POD_START
#pf_trace kshrci start




## =head1  Some settings to make vim the default editor.
##
## This should be in kshrci.peeterj instead but some people probably expect it now.
##
export VISUAL=vim

export EDITOR=vim

alias vi=vim
##
## =cut





## =head1
set -o vi
##
## This is my (Peeter's) preference (vi style command line completion).
## This should be in kshrci.peeterj instead but some people probably expect it now.
## Better would be just the following aliases to let people choose themselves (emacs is the default).

alias sv='set -o vi'

alias se='set -o emacs'
##
## =cut





## =head1
alias la='ls -a'
##
## ls with hidden files.
##
## =cut





## =head1
alias ll='ls -l'
##
## ls with times, owners, ...
##
## =cut




## =head1
alias b='cd ..'
##
## Chdir to parent dir.
##
## =cut



## =head1
alias pj='ps -ef | grep "^ *${USER?}" | sort -n -k 3 -k 2'
##
## Processes I (pj) Own.  Should have called this something else or put it in kshrci.peeterj
##
## =cut





#pf_trace kshrci misc



## =head1
alias setdis='`getdisplay`'
##
## The getdisplay program will attempt to figure out the DISPLAY variable value from 'who' output, and other info, but can't
## adjust environment in the current shell.  This alias takes the results and adjusts the current shell's DISPLAY var if possible.
##
## =cut




alias pp='ps -f -u $USER --forest'
alias results='cat ""`find . -name \*.res` > ./all.out'
alias ddr='cd `goToDump.pl`'

export PATH=$PATH:$HOME/.vim_backup/myTools/
export PATH=$PATH:$HOME/linuxConfig/
