##      ##
## path ##
##      ##

npm_path=$(npm config get prefix)
npm_bin_path="$npm_path/bin"
if [[ -d "$npm_path" && -d "$npm_bin_path" ]]; then
    export PATH="$npm_bin_path:$PATH"
fi

export PATH="$HOME/bin:$PATH"
