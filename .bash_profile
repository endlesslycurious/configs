# Go variable for project location
export GOPATH="$HOME/Source/GoWorkspace"

# Add binaries from Go Workspace to path
export PATH="$GOPATH/bin:$PATH"

# For Docker tab completion: https://blog.alexellis.io/docker-mac-bash-completion/
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
