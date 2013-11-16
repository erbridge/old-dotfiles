# include files from .bash if they exist
if [ -d "$HOME/.bash" ]; then
    if [ -f "$HOME/.bash/aliases" ]; then
        . $HOME/.bash/aliases
    fi

    if [ -f "$HOME/.bash/completions" ]; then
        . $HOME/.bash/completions
    fi

    if [ -f "$HOME/.bash/config" ]; then
        . $HOME/.bash/config
    fi

    if [ -f "$HOME/.bash/paths" ]; then
        . $HOME/.bash/paths
    fi

    if [ -f "$HOME/.bash/prompt" ]; then
        . $HOME/.bash/prompt
    fi
fi

