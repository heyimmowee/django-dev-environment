# import bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# prompt
PS1='\[\e[0;32m\]\u\[\e[m\]-docker \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '

# virtualenvwrapper config
export WORKON_HOME="$HOME/.virtualenvs"
source /usr/local/bin/virtualenvwrapper.sh
complete -o default -o nospace -F _virtualenvs v
