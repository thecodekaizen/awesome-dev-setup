# awesome-dev-setup

<p align="center">
  <img src="https://img.shields.io/badge/platform-macOS-black?style=flat-square&logo=apple&logoColor=white" alt="macOS" />
  <img src="https://img.shields.io/badge/shell-Zsh-89e051?style=flat-square&logo=gnu-bash&logoColor=white" alt="Zsh" />
  <img src="https://img.shields.io/badge/package_manager-Homebrew-fbb040?style=flat-square&logo=homebrew&logoColor=white" alt="Homebrew" />
  <img src="https://img.shields.io/badge/secrets-Gitleaks-red?style=flat-square&logo=git&logoColor=white" alt="Gitleaks" />
  <img src="https://img.shields.io/badge/license-MIT-blue?style=flat-square" alt="MIT License" />
  <img src="https://img.shields.io/badge/PRs-welcome-brightgreen?style=flat-square" alt="PRs Welcome" />
</p>

<p align="center"><b>A minimal, secure, AI-first development environment for macOS.</b></p>

<p align="center">A carefully curated Mac setup for software engineers who want to spend less time configuring their machine and more time building.</p>

<p align="center">
  <a href="#philosophy">Philosophy</a> ·
  <a href="#whats-included">What's included</a> ·
  <a href="#directory-structure">Structure</a> ·
  <a href="#install">Install</a> ·
  <a href="#ai-first-development">AI-first dev</a> ·
  <a href="#security">Security</a> ·
  <a href="#contributing">Contributing</a>
</p>

---

## Philosophy

| Principle | Over |
|---|---|
| 🪶 Minimal | Bloated |
| 🔒 Secure | Convenient |
| ♻️ Reproducible | Manually configured |
| 🧑‍💻 Human-controlled | AI-autonomous |
| ✅ Useful defaults | Endless customization |

## What's included

### Development stack

| Category | Tools |
|---|---|
| 🖥️ Terminal | [Ghostty](https://ghostty.org) |
| ✏️ Editor | [Zed](https://zed.dev) |
| 🐚 Shell | Zsh + [Starship](https://starship.rs) prompt |
| 🪟 Multiplexer | tmux |
| 🤖 AI coding agents | Claude Code, Codex |
| 🧬 Runtime management | [mise](https://mise.jdx.dev) (languages are installed and pinned through mise, not Homebrew) |
| 📦 Containers | Docker Desktop (optional, not installed by `bootstrap.sh`) |
| ☁️ Cloud / orchestration | Kubernetes CLI, Helm, Google Cloud CLI |
| 🗄️ Data stores | PostgreSQL client libs (`libpq`), Redis |

### CLI tools

<p>
<img src="https://img.shields.io/badge/fzf-000?style=flat-square" />
<img src="https://img.shields.io/badge/ripgrep-000?style=flat-square" />
<img src="https://img.shields.io/badge/fd-000?style=flat-square" />
<img src="https://img.shields.io/badge/bat-000?style=flat-square" />
<img src="https://img.shields.io/badge/eza-000?style=flat-square" />
<img src="https://img.shields.io/badge/zoxide-000?style=flat-square" />
<img src="https://img.shields.io/badge/jq-000?style=flat-square" />
<img src="https://img.shields.io/badge/yq-000?style=flat-square" />
<img src="https://img.shields.io/badge/lazygit-000?style=flat-square" />
<img src="https://img.shields.io/badge/gh-000?style=flat-square" />
<img src="https://img.shields.io/badge/gitleaks-000?style=flat-square" />
</p>

The full, authoritative list always lives in [`Brewfile`](./Brewfile) — treat the table and badges above as a guide, not the source of truth.

## Directory structure

```
.
├── bootstrap.sh              # Entry point: installs packages, symlinks config
├── Brewfile                  # Homebrew formulae + casks
├── AGENTS.md                 # Rules AI coding agents must follow in this repo
├── starship.toml             # Shell prompt configuration
├── .zshrc.local.example      # Template for machine-specific, uncommitted config
├── ghostty/
│   └── config                 # Terminal config, symlinked to ~/.config/ghostty/config
├── git/
│   └── gitignore_global       # Symlinked to ~/.gitignore_global, wired into git config
├── scripts/
│   └── init-agent-rules       # Installed to ~/.local/bin, see "AI-first development" below
├── tmux/
│   └── tmux.conf               # Symlinked to ~/.tmux.conf
└── zsh/
    └── .zshrc                  # Symlinked to ~/.zshrc if one doesn't already exist
```

## Install

**Requirements:** macOS (Apple Silicon or Intel) with [Homebrew](https://brew.sh) installed.

```bash
git clone https://github.com/thecodekaizen/awesome-dev-setup.git
cd awesome-dev-setup
zsh bootstrap.sh
```

### What `bootstrap.sh` actually does

```mermaid
flowchart TD
    A[zsh bootstrap.sh] --> B{macOS + Homebrew?}
    B -- no --> Z[Exit with error]
    B -- yes --> C[brew bundle --file=Brewfile]
    C --> D[Create ~/.config dirs]
    D --> E["Symlink ghostty/config,\nstarship.toml, tmux.conf,\ngitignore_global"]
    E --> F[Set git core.excludesfile]
    F --> G[Install scripts/init-agent-rules\nto ~/.local/bin]
    G --> H{~/.zshrc exists?}
    H -- "no" --> I[Symlink zsh/.zshrc]
    H -- "yes, already ours" --> J[Leave as-is]
    H -- "yes, foreign file" --> K["Back up to\n~/.zshrc.backup.TIMESTAMP"]
    I --> L[Done]
    J --> L
    K --> L
```

It's idempotent and non-destructive — re-running it is always safe, and it will never silently overwrite a `.zshrc` you already had.

## AI-first development

AI coding agents (Claude Code, Codex) are installed as tools the developer directs — not as an autonomous replacement for the developer. Two pieces enforce that in practice:

```mermaid
flowchart LR
    subgraph This repo
        AG[AGENTS.md<br/>rules for agents]
        SC[scripts/init-agent-rules]
    end
    SC -- "cp + chmod +x during bootstrap.sh" --> LB["~/.local/bin/init-agent-rules"]
    LB -- "run inside any new project" --> NP["New project"]
    AG -. "same rule set" .-> NP
```

- **[`AGENTS.md`](./AGENTS.md)** — the rules any agent operating in this repo (or a repo you apply this setup to) is expected to follow: inspect before changing, keep diffs small and focused, never touch secrets or production credentials, never rewrite Git history or force-push without being asked, run tests/lint before declaring work done, and report what couldn't be verified.
- **`scripts/init-agent-rules`** — installed to `~/.local/bin` by `bootstrap.sh`, this drops a copy of those rules into a new project so agents pick up the same guardrails there.

## Security

- 🚫 The repo itself never contains private keys, API tokens, passwords, `.env` files, cloud credentials, certificates, or machine-specific configuration.
- 🔍 `gitleaks` is installed via the Brewfile so you have a secret-scanning CLI available; run it manually or wire it into CI/pre-commit for your own projects — it is not auto-triggered by anything in this repo.
- 🔑 Machine-specific values (API keys, local paths, anything you don't want in version control) belong in `~/.zshrc.local`, which is sourced by `zsh/.zshrc` but is never committed. Start from `.zshrc.local.example`.

## Reproducibility

Configuration lives in version control so the whole setup can be rebuilt on a new Mac in one command. Anything machine-specific stays in `~/.zshrc.local` and is explicitly kept out of the repo.

## Customize

This is a starting point, not a religion. Fork it, strip out what you don't use, and add your own tools and config.

## What's deliberately missing

| ❌ Excluded | Why |
|---|---|
| Hundreds of aliases | Cognitive overhead outweighs the convenience |
| Random shell plugins | Slower shell startup, more to break |
| Unnecessary background services | Minimal footprint |
| Hard-coded personal paths | Not reproducible on another machine |
| Credentials | Never belong in version control |
| Production configuration | This is a dev environment, not a deploy target |
| Bloat | See: Philosophy |

## Contributing

Private opinions are welcome to become collective improvements. Keep contributions focused and useful, avoid personal configuration, and test `bootstrap.sh` before opening a PR.

## License

[MIT](./LICENSE)
