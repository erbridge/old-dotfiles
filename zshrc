##         ##
## exports ##
##         ##


export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;44:ow=37;44:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
export TERM=linux
export EDITOR=nano


##               ##
## pre-zsh setup ##
##               ##


if which envoy > /dev/null 2>&1; then
    envoy -t ssh-agent
    source <(envoy -p)
fi


##           ##
## zsh setup ##
##           ##


# oh-my-zsh settings
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"
REPORTTIME=10
DISABLE_AUTO_UPDATE="true"

# zsh-syntax-highlighting settings
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# autoupdate-zgen settings
ZGEN_PLUGIN_UPDATE_DAYS=1
ZGEN_SYSTEM_UPDATE_DAYS=1

# Setup zgen
ZGEN_CLONE_DIR="$HOME/zgen"

if [ ! -f "$ZGEN_CLONE_DIR/zgen.zsh" ]; then
    git clone git@github.com:tarjoilija/zgen.git "$ZGEN_CLONE_DIR"
fi

source "$ZGEN_CLONE_DIR/zgen.zsh"

if ! zgen saved; then
    # oh-my-zsh plugins
    zgen oh-my-zsh

    zgen oh-my-zsh plugins/autojump
    zgen oh-my-zsh plugins/bower
    zgen oh-my-zsh plugins/bundler
    zgen oh-my-zsh plugins/colored-man
    zgen oh-my-zsh plugins/django
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/ember-cli
    zgen oh-my-zsh plugins/extract
    zgen oh-my-zsh plugins/fabric
    zgen oh-my-zsh plugins/gem
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/git-extras
    zgen oh-my-zsh plugins/golang
    zgen oh-my-zsh plugins/heroku
    zgen oh-my-zsh plugins/node
    zgen oh-my-zsh plugins/npm
    zgen oh-my-zsh plugins/pip
    zgen oh-my-zsh plugins/python
    zgen oh-my-zsh plugins/rbenv
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/systemadmin
    zgen oh-my-zsh plugins/systemd
    zgen oh-my-zsh plugins/vagrant
    zgen oh-my-zsh plugins/virtualenvwrapper

    # zsh-users plugins
    zgen load zsh-users/zsh-completions src
    zgen load zsh-users/zsh-history-substring-search
    zgen load zsh-users/zsh-syntax-highlighting

    # Other plugins
    zgen load akoenig/gulp-autocompletion-zsh
    zgen load djui/alias-tips
    zgen load horosgrisa/zsh-gvm
    zgen load supercrabtree/k
    zgen load Tarrasch/zsh-bd
    zgen load unixorn/autoupdate-zgen

    # Theme
    zgen load erbridge/triangle-zsh-theme triangle

    zgen save
fi

# zsh-history-substring-search key bindings
zmodload zsh/terminfo
if [[ -n "$terminfo[kcuu1]" ]]; then
    bindkey "$terminfo[kcuu1]" history-substring-search-up
fi
if [[ -n "$terminfo[kcud1]" ]]; then
    bindkey "$terminfo[kcud1]" history-substring-search-down
fi


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


if which pkgfile > /dev/null 2>&1; then
    command_not_found_handler() {
        local pkgs cmd="$1"

        pkgs=(${(f)"$(pkgfile -b -v -- "$cmd" 2>/dev/null)"})
        if [[ -n "$pkgs" ]]; then
            printf '%s may be found in the following packages:\n' "$cmd"
            printf '  %s\n' "${pkgs[@]}"
        fi

        return 127
    }
fi


##                 ##
## welcome message ##
##                 ##


if which is-online > /dev/null 2>&1; then
    is-online
else
    echo "Welcome!"
fi
