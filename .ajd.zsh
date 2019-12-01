# Plugins etc.
source "$HOME/.antigen.zsh"
antigen theme romkatv/powerlevel10k
antigen bundle git
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

# Zsh functions
fpath=($HOME/.zfn $fpath)
autoload -U $fpath[1]/*(.:t)
