Write-Host "== Git Sanity Check =="

$repo = git rev-parse --show-toplevel 2>$null
if (-not $repo) { $repo = "N/A" }
Write-Host "Repo: $repo"

$attrFile = git config --global core.attributesfile 2>$null
if (-not $attrFile) { $attrFile = "not set" }
Write-Host "Global .gitattributes: $attrFile"
Write-Host ""

Write-Host "— Attributes (first 200 lines) —"
git check-attr --all -- :/ | Select-Object -First 200
Write-Host ""

Write-Host "— EOL summary (LF/CRLF) —"
git check-attr eol -- :/ | Sort-Object | Get-Unique
Write-Host ""

Write-Host "— Binary files (sample) —"
git check-attr binary -- :/ | Select-String ": binary: set" | Select-Object -First 50
Write-Host ""

Write-Host "— Renormalize preview (dry run) —"
git add --renormalize --dry-run .
Write-Host ""
Write-Host 'If the preview looks good:'
Write-Host '  git add --renormalize . && git commit -m "Normalize line endings per .gitattributes"'
