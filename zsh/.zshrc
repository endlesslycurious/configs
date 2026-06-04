# add homebrew to path
export PATH="/opt/homebrew/bin:$PATH"

# add homebrew LLVM to path
export PATH="/opt/homebrew/opt/llvm/bin/:$PATH"

# Add binaries from Go default workspace to path
export PATH="$PATH:$HOME/go/bin"

# pipenv create virtual environment folders inside projects
export PIPENV_VENV_IN_PROJECT=1

# oh-my-posh setup
eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/catppuccin_macchiato.omp.json)"
