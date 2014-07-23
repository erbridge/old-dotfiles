##         ##
## exports ##
##         ##


export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;44:ow=37;44:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';

if [ "x$COLORTERM" = "xgnome-terminal" -a "x$TERM" = "xxterm" ] && infocmp linux > /dev/null 2>&1; then
    export TERM=linux
fi

export EDITOR=nano

export PATH="$HOME/bin:$PATH"


##           ##
## oh-my-zsh ##
##           ##


ZSH=$HOME/.oh-my-zsh

ZSH_THEME="triangle"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"
REPORTTIME=10

plugins=(autojump bower bundler colored-man django extract fabric gem git git-extras heroku history-substring-search node npm pip python rand-quote rbenv sudo systemadmin virtualenvwrapper)

if [[ $('uname') == 'Linux' ]]; then
    plugins+=(systemd)
elif [[ $('uname') == 'Darwin' ]]; then
    plugins+=(brew brew-cask sublime)
fi

# Must happen before history-substring-search is loaded.
if [[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

source "$ZSH/oh-my-zsh.sh"


##         ##
## aliases ##
##         ##


if which /usr/bin/aura > /dev/null 2>&1; then
    function aura() {
        AURA="$(/usr/bin/aura "$@" 2>&1)"

        if echo "$AURA" | grep -q '^aura >>= .*Please check your input.*$\|^aura >>= .*You have to use `.*sudo.*` for that.*$'; then
            sudo /usr/bin/aura "$@"
        else
            echo "$AURA"
        fi
    }
fi


##       ##
## setup ##
##       ##


if which envoy > /dev/null 2>&1; then
    envoy -t ssh-agent
    source <(envoy -p)
fi

if which pkgfile > /dev/null 2>&1; then
    command_not_found_handler() {
        local pkgs cmd="$1"

        pkgs=(${(f)"$(pkgfile -b -v -- "$cmd" 2>/dev/null)"})
        if [[ -n "$pkgs" ]]; then
            printf '%s may be found in the following packages:\n' "$cmd"
            printf '  %s\n' $pkgs[@]
        fi

        return 127
    }
fi


##                 ##
## welcome message ##
##                 ##


if which quote > /dev/null 2>&1; then
    if which wget > /dev/null 2>&1 && wget -q -O - --tries=10 --timeout=1 http://google.com > /dev/null 2>&1; then
        quote
    else
        echo "No internet!"
    fi
else
    echo "Welcome!"
fi
