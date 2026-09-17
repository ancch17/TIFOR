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
# Publish ONLY the website: index.html and the assets folder (allowlist).
# Everything else in this folder (assessment papers, answer keys, notes, source video, teaching pack) stays private.
Get-ChildItem -Path $dst -Force | Where-Object { $_.Name -notin @('index.html','assets') } | Remove-Item -Recurse -Force
Copy-Item (Join-Path $src 'index.html') (Join-Path $dst 'index.html') -Force
robocopy (Join-Path $src 'assets') (Join-Path $dst 'assets') /MIR | Out-Null
if ($LASTEXITCODE -ge 8) { throw "robocopy failed with exit code $LASTEXITCODE" }
$ErrorActionPreference = 'Continue'   # git writes progress/warnings to stderr
git -C $root add -A tifor
if (git -C $root status --porcelain tifor) {
  git -C $root commit -m "tifor: deploy $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
  git -C $root push
  Write-Host "Pushed. GitHub Pages will publish https://ac-eduworks.com/tifor/ in about a minute."
} else {
  Write-Host "Nothing to deploy - tifor/ is already up to date."
}
