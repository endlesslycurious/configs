# add homebrew to path
export PATH="/opt/homebrew/bin:$PATH"

# Go variable for project location
export GOPATH="$HOME/Source/GoWorkspace"

# Add binaries from Go Workspace to path
export PATH="$GOPATH/bin:$PATH"

# pipenv create virtual environment folders inside projects
export PIPENV_VENV_IN_PROJECT=1

# oh-my-posh setup
eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/catppuccin_macchiato.omp.json)"
