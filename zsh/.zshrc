# ─────────────────────────────────────────────
# Homebrew
# ─────────────────────────────────────────────

eval "$(brew shellenv)"


# ─────────────────────────────────────────────
# Runtime / shell tools
# ─────────────────────────────────────────────

eval "$(mise activate zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"


# ─────────────────────────────────────────────
# Starship
# ─────────────────────────────────────────────

eval "$(starship init zsh)"


# ─────────────────────────────────────────────
# Python
# ─────────────────────────────────────────────

alias python=python3
alias pip=pip3


# ─────────────────────────────────────────────
# Local binaries
# ─────────────────────────────────────────────

export PATH="$PATH:$HOME/.local/bin"



# ─────────────────────────────────────────────
# binutils
# ─────────────────────────────────────────────

export PATH="$(brew --prefix binutils)/bin:$PATH"


# ─────────────────────────────────────────────
# PostgreSQL
# ─────────────────────────────────────────────

export PATH="$(brew --prefix libpq)/bin:$PATH"


# ─────────────────────────────────────────────
# Personal aliases
# ─────────────────────────────────────────────

alias ll='eza -lah --git'
alias la='eza -a'
alias cat='bat'
alias grep='rg'
alias find='fd'
alias lg='lazygit'

alias gs='git status'
alias gl='git log --oneline --graph --decorate'


# ─────────────────────────────────────────────
# Kubernetes
# ─────────────────────────────────────────────

alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgd='kubectl get deploy'
alias kctx='kubectl config current-context'
alias kns='kubectl config set-context --current --namespace'
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
