
alias ls=lsd
alias vim=nvim
export VISUAL=nvim
export EDITOR=nvim

# Disable keyring in pip
PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

# pfetch
starship init fish | source
