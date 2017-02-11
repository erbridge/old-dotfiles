##      ##
## path ##
##      ##


yarn_internal_bin_path="$HOME/.config/yarn/global/node_modules/.bin"
if [[ -d "$yarn_internal_bin_path" ]]; then
    export PATH="$yarn_internal_bin_path:$PATH"
fi

npm_path=$(npm config get prefix)
npm_bin_path="$npm_path/bin"
if [[ -d "$npm_path" && -d "$npm_bin_path" ]]; then
    export PATH="$npm_bin_path:$PATH"
fi

export GOPATH="$HOME/dev/golang"
export PATH="$GOPATH/bin:$PATH"

export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$ANDROID_HOME/tools:$PATH"

export PATH="$HOME/bin:$PATH"
