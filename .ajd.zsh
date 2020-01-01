# Plugins etc.
source "$HOME/.antigen.zsh"
antigen theme romkatv/powerlevel10k
antigen use oh-my-zsh
antigen bundle git
antigen bundle common-aliases
antigen bundle command-not-found
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions
antigen apply


# Zsh functions
fpath=($HOME/.zfn $fpath)
autoload -U $fpath[1]/*(.:t)

# Localize
if [[ -f $HOME/.local.zsh ]]; then
    source $HOME/.local.zsh
fi
