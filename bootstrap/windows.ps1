$ErrorActionPreference = "Stop"

$DotfilesDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

Write-Host "========================================"
Write-Host " awesome-dev-setup"
Write-Host "========================================"
Write-Host ""
Write-Host "Platform: Windows"
Write-Host ""

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Error "winget is required."
    exit 1
}

$Packages = @(
    "Git.Git",
    "GitHub.cli",
    "junegunn.fzf",
    "BurntSushi.ripgrep.MSVC",
    "sharkdp.fd",
    "sharkdp.bat",
    "eza-community.eza",
    "ajeetdsouza.zoxide",
    "jqlang.jq",
    "MikeFarah.yq",
    "JesseDuffield.lazygit",
    "jdx.mise",
    "Starship.Starship",
    "Kubernetes.kubectl",
    "Helm.Helm",
    "ZedIndustries.Zed"
)

Write-Host "==> Installing Windows tools..."

foreach ($Package in $Packages) {
    Write-Host "    $Package"

    winget install `
        --id $Package `
        --exact `
        --accept-source-agreements `
        --accept-package-agreements
}

Write-Host ""
Write-Host "==> Creating configuration directories..."

New-Item -ItemType Directory -Force `
    "$HOME\.config\awesome-dev-setup" | Out-Null

New-Item -ItemType Directory -Force `
    "$HOME\.local\bin" | Out-Null

Copy-Item `
    "$DotfilesDir\AGENTS.md" `
    "$HOME\.config\awesome-dev-setup\AGENTS.md" `
    -Force

Write-Host ""
Write-Host "==> Windows setup complete."
Write-Host ""
Write-Host "For the full Unix-style environment, use WSL"
Write-Host "and run bootstrap.sh inside the Linux environment."
