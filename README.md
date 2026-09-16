# awesome-dev-setup

> A minimal, secure, AI-first development environment for macOS.

A carefully curated Mac setup for software engineers who want to spend less time configuring their machine and more time building.

## Philosophy

- Minimal over bloated
- Secure over convenient
- Reproducible over manually configured
- Human-controlled over Ai-autonomous
- Useful defaults over endless customization

## What's included

### Development stack

- Ghostty
- Zed (editor)
- Zsh + Starship
- tmux
- Codex + Claude Code
- mise
- Docker + Compose
- Kubernetes + Helm
- GCloud
- PostgreSQL + Redis

 Cli tools

fzf, ripgrep, fd, bat, eza, zoxide, jq, yq, lazygit

## Install

Requirements: macOS and Homebrew, with Apple Silicon recommended.

### Clone and bootstrap

```bash
git clone https://github.com/thecodekaizen/awesome-dev-setup.git
cd awesome-dev-setup
zsh bootstrap.sh
```

## AI-first development

[AI is used as an engineering tool, not an autonomous replacement for the developer. ]

## Security

The repo does not include private keys, API tokens, passwords, .env files, cloud credentials, certificates, or machine-specific configuration.

Gitleaks scans commits for potential secrets. Machine-specific configuration stays out of the repo.

## Reproducibility

The configuration lives in version control so the setup can be reproduced on a new Mac.

## Customize

This is a starting point, not a religion. Fork it, remove tools you don't need, and add your own.

## What's deliberately missing

- Hundreds of aliases
- Random shell plugins
- Unnecessary background services
- Hard-coded personal paths
- Credentials
- Production configuration
- Bloat

## Contributing

Private opinions are welcome to become collective improvements. Keep contributions focused and useful, avoid personal configuration, and test the bootstrap.

## License

MIT
