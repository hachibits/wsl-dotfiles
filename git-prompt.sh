if test -f /etc/profile.d/git-sdk.sh
then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi

if test -f ~/.config/git/git-prompt.sh
then
	. ~/.config/git/git-prompt.sh
else
  fast_git_ps1 ()                                                                              
  {                                                                                            
      printf -- "$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ {\1} /')"    
  }                                                                                            

  PS1='\[\033]0;$MSYSTEM:\w\007                                                                
  \033[32m\]\u@\h \[\033[33m\w$(fast_git_ps1)\033[0m\]                                         
  $ '  
fi

MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc

# Evaluate all user-specific Bash completion scripts (if any)
if test -z "$WINELOADERNOEXEC"
then
	for c in "$HOME"/bash_completion.d/*.bash
	do
		# Handle absence of any scripts (or the folder) gracefully
		test ! -f "$c" ||
		. "$c"
	done
fi
