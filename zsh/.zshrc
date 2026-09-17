# awesome-dev-setup
# Shared Zsh configuration. Keep machine-specific settings in ~/.zshrc.local.

# Homebrew
if command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
fi

# mise
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

# zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# fzf
if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
fi

# Starship
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# Python
if command -v python3 >/dev/null 2>&1 && ! command -v python >/dev/null 2>&1; then
    alias python=python3
fi

if command -v pip3 >/dev/null 2>&1 && ! command -v pip >/dev/null 2>&1; then
    alias pip=pip3
fi

# Local user binaries
if [[ -d "$HOME/.local/bin" ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Homebrew packages with non-standard executable locations
if command -v brew >/dev/null 2>&1; then
    if brew list binutils >/dev/null 2>&1; then
        export PATH="$(brew --prefix binutils)/bin:$PATH"
    fi

    if brew list libpq >/dev/null 2>&1; then
        export PATH="$(brew --prefix libpq)/bin:$PATH"
    fi
fi

# Modern CLI aliases
if command -v eza >/dev/null 2>&1; then
    alias ll='eza -lah --git'
    alias la='eza -a'
fi

if command -v bat >/dev/null 2>&1; then
    alias cat='bat'
fi

if command -v rg >/dev/null 2>&1; then
    alias grep='rg'
fi

if command -v fd >/dev/null 2>&1; then
    alias find='fd'
elif command -v fdfind >/dev/null 2>&1; then
    alias find='fdfind'
fi

if command -v lazygit >/dev/null 2>&1; then
    alias lg='lazygit'
fi

alias gs='git status'
alias gl='git log --oneline --graph --decorate'

# Kubernetes
if command -v kubectl >/dev/null 2>&1; then
    alias k='kubectl'
    alias kgp='kubectl get pods'
    alias kgs='kubectl get svc'
    alias kgd='kubectl get deploy'
    alias kctx='kubectl config current-context'
    alias kns='kubectl config set-context --current --namespace'
fi

# Machine-specific configuration
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
