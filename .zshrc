# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/mike/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

ZSH_DISABLE_COMPFIX="true"


bindkey "[C" forward-word
bindkey "[D" backward-word

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#Getting kubernetes pods
alias kpods="kubectl get pods"

#Getting kubernetes services
alias kservices="kubectl get services"

#Short git checkout
alias co="git checkout"

#Short maven commands
alias mi="mvn clean install"
alias mist="mvn clean install -DskipTests"
alias mr="mvn spring-boot:run"

#runs project with spring boot with open debug port. Must be executed in web module
alias jdebug="mvn spring-boot:run -Dspring-boot.run.jvmArguments=\"-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005\""

#finding the podname for an unqiue substr. Example: "crd-apis" translates to "crd-apis-5d999fc785-swjtt"
function podname() {
    local PODNAME=$(kubectl get pods | awk '{print $1}' | grep "$1")
    print $PODNAME
}

#example use "kbash crd-apis" translates to kubectl exec -it crd-apis-5d999fc785-swjtt -- bash
function kbash() {
    kubectl exec -it $(podname $1) -- bash
}

#example use "klogs crd-apis" translates to kubectl logs -f crd-apis-5d999fc785-swjtt  
function klogs() {
    kubectl logs -f $(podname $1)
}

#collection of commands for portforwarding local ports to kubernetes
alias portforwarding="kubectl port-forward service/oracledb12 1521:1521 -n crd-dev & kubectl port-forward service/crd-apis-service 8085:8080 -n crd-dev  & kubectl port-forward service/crd-apis-admin-service 9991:9990 -n crd-dev"

#kubectl port-forward crd-jbpm-standalone-6b8cc98b95-6mbp5 9990:9990
function kport(){
    echo kubectl port-forward $(podname $1) $2:$2
    kubectl port-forward $(podname $1) $2:$2
}
