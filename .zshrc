# add homebrew to path
export PATH="/opt/homebrew/bin:$PATH"

# oh-my-posh setup
eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/catppuccin_macchiato.omp.json)"
