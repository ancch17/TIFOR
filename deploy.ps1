# Deploy this site to https://ac-eduworks.com/tifor/
# Mirrors the site files into the tifor/ folder of ancch17/ac-eduworks-root (the repo that owns ac-eduworks.com on GitHub Pages).
$ErrorActionPreference = 'Stop'
$src  = $PSScriptRoot
$root = Join-Path $env:USERPROFILE 'ac-eduworks-root'
if (-not (Test-Path (Join-Path $root '.git'))) {
  gh repo clone ancch17/ac-eduworks-root $root
} else {
  git -C $root pull --ff-only
}
$dst = Join-Path $root 'tifor'
New-Item -ItemType Directory -Force -Path $dst | Out-Null
# Mirror (deletes files removed from the source); skip git and deploy-only files
robocopy $src $dst /MIR /XD .git /XF deploy.ps1 README.md .nojekyll | Out-Null
if ($LASTEXITCODE -ge 8) { throw "robocopy failed with exit code $LASTEXITCODE" }
git -C $root add -A tifor
if (git -C $root status --porcelain tifor) {
  git -C $root commit -m "tifor: deploy $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
  git -C $root push
  Write-Host "Pushed. GitHub Pages will publish https://ac-eduworks.com/tifor/ in about a minute."
} else {
  Write-Host "Nothing to deploy - tifor/ is already up to date."
}
