# see https://stackoverflow.com/a/62157937 & https://misc.flogisoft.com/bash/tip_colors_and_formatting
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

# Green user@host blue path
export PS1="$GREEN\u@$GREEN\h $BLUE\w$RESET$ "
export CLICOLOR=1
export LSCOLORS=GxFxCxDxbxegedabagaced


# Go variable for project location
export GOPATH="$HOME/Source/GoWorkspace"

# Add binaries from Go Workspace to path
export PATH="$GOPATH/bin:$PATH"

# For Docker tab completion: https://blog.alexellis.io/docker-mac-bash-completion/
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# pipenv create virtual environment folders inside projects
export PIPENV_VENV_IN_PROJECT=1

complete -C /usr/local/bin/terraform terraform

# for coursera algorithms course
export CLASSPATH=$CLASSPATH:/usr/local/lift/lib/algs4.jar

# set default kubernetes config to be for the picocluster
export KUBECONFIG=~/Source/PicoCluster/k3s/k3s.yaml
