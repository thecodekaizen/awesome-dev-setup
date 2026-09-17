# awesome-dev-setup

A minimal, secure, AI-first development environment for macOS.

A carefully curated Mac setup for software engineers who want to spend less time configuring their machine and more time building.

## Philosophy

* Minimal over bloated
* Secure over convenient
* Reproducible over manually configured
* Human-controlled over AI-autonomous
* Useful defaults over endless customization

## What's included

**Development stack**

* Ghostty (terminal)
* Zed (editor)
* Zsh + Starship
* tmux
* Claude Code + Codex
* mise (language runtimes are managed through mise, not Homebrew)
* Kubernetes CLI + Helm
* Google Cloud CLI
* PostgreSQL client
* Redis
* Docker Desktop is supported but intentionally not managed by the Brewfile

**CLI tools**

`fzf`, `ripgrep`, `fd`, `bat`, `eza`, `zoxide`, `jq`, `yq`, `lazygit`, `gh`, `gitleaks`

The Brewfile is the source of truth. This list is only a summary.

## Directory structure

```text
.
├── bootstrap.sh              # installs packages and configures the environment
├── Brewfile                  # Homebrew formulae + casks
├── AGENTS.md                 # rules for AI coding agents
├── starship.toml
├── .zshrc.local.example      # template for machine-specific, uncommitted config
├── ghostty/
│   └── config
├── git/
│   └── gitignore_global
├── scripts/
│   └── init-agent-rules
├── tmux/
│   └── tmux.conf
└── zsh/
    └── .zshrc
```

## Install

Requirements: macOS (Apple Silicon or Intel) with [Homebrew](https://brew.sh/).

```bash
git clone https://github.com/thecodekaizen/awesome-dev-setup.git
cd awesome-dev-setup
zsh bootstrap.sh
```

`bootstrap.sh` is designed to be idempotent and non-destructive. It:

1. Installs everything in `Brewfile` via `brew bundle`.
2. Creates the required configuration directories.
3. Symlinks Ghostty, Starship, tmux, and Git configuration into place.
4. Configures Git to use the shared global `.gitignore`.
5. Installs `init-agent-rules` to `~/.local/bin`.
6. Installs the repository Zsh configuration only when `~/.zshrc` does not already exist.
7. Backs up an existing `~/.zshrc` before making any changes to it.

Machine-specific configuration belongs in `~/.zshrc.local`.

## AI-first development

AI coding agents are tools the developer directs, not autonomous replacements for the developer.

This setup includes two pieces to make that workflow explicit:

* [**`AGENTS.md`**](AGENTS.md) — shared rules for AI coding agents. The rules cover inspecting existing code before changing it, keeping diffs focused, protecting secrets and production credentials, avoiding destructive Git operations, and verifying changes with tests and tooling.
* **`scripts/init-agent-rules`** — installs a helper that can copy these rules into a project. It refuses to overwrite an existing `AGENTS.md`.

Run it from a project directory:

```bash
init-agent-rules
```

Or provide a project path:

```bash
init-agent-rules ~/code/my-project
```

The helper uses the copy of `AGENTS.md` installed by `bootstrap.sh`, so it does not depend on where this repository was cloned.

## Security

The repository itself contains no private keys, API tokens, passwords, `.env` files, cloud credentials, certificates, or machine-specific configuration.

Security-related defaults include:

* Git SSH authentication
* SSH commit signing
* Global secret-file ignores
* `gitleaks` for secret scanning
* No production credentials or infrastructure
* No hard-coded personal paths
* No automatic destructive Git operations

`gitleaks` is available as a CLI for scanning repositories. This setup does not automatically run it on every commit.

Machine-specific values such as API keys, local paths, and other private configuration belong in:

```text
~/.zshrc.local
```

Start with:

```text
.zshrc.local.example
```

Do not commit `~/.zshrc.local`.

## Reproducibility

Configuration lives in version control so the development environment can be rebuilt on another Mac.

The setup supports both Apple Silicon and Intel Macs and avoids hard-coded Homebrew paths.

Machine-specific configuration stays outside the repository in `~/.zshrc.local`.

## Customize

This is a starting point, not a religion.

Fork it, remove tools you don't need, and add your own.

Keep personal or machine-specific configuration out of the shared baseline.

## What's deliberately missing

* Hundreds of aliases
* Random shell plugins
* Unnecessary background services
* Hard-coded personal paths
* Credentials
* Production configuration
* Machine-specific applications
* Bloat

## Contributing

Private opinions are welcome to become collective improvements.

Keep contributions focused and useful, avoid personal configuration, and test `bootstrap.sh` before opening a PR.

## License

MIT
