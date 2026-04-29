# SpecFlow post-commit hook (PowerShell)
# Detects .specflow doc changes and writes sync trigger file for next SessionStart.

$ErrorActionPreference = "Stop"

try {
    $root = git rev-parse --show-toplevel 2>$null
} catch {
    exit 0
}

$specflowDir = Join-Path $root ".specflow"
$triggerFile = Join-Path $specflowDir ".sync-trigger.json"

# Get files changed in the last commit
$changed = git diff-tree --no-commit-id -r --name-only HEAD 2>$null
if (-not $changed) { exit 0 }

$pmChanged = $changed | Where-Object { $_ -match '^\.specflow/pm-docs/' }
$specChanged = $changed | Where-Object { $_ -match '^\.specflow/specs/' }

if (-not $pmChanged -and -not $specChanged) {
    exit 0
}

# Determine direction
$direction = "both"
if ($pmChanged -and -not $specChanged) {
    $direction = "doc-to-code"
} elseif (-not $pmChanged -and $specChanged) {
    $direction = "code-to-doc"
}

# Collect affected features
$allChanged = @($pmChanged) + @($specChanged)
$features = @()
foreach ($f in $allChanged) {
    if ($f -match '(?:pm-docs|specs/active)/([^/]+)') {
        $features += $Matches[1]
    }
}
$features = $features | Sort-Object -Unique

$commitHash = git rev-parse HEAD 2>$null
$commitMsg = (git log -1 --format=%s HEAD 2>$null) -replace '"', '\"'
$timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

# Build JSON
$changedJson = ($allChanged | ForEach-Object { "`"$_`"" }) -join ","
$featJson = ($features | ForEach-Object { "`"$_`"" }) -join ","

if (-not (Test-Path $specflowDir)) {
    New-Item -ItemType Directory -Path $specflowDir -Force | Out-Null
}

$json = @"
{
  "version": "1",
  "triggered_at": "${timestamp}",
  "commit": "${commitHash}",
  "direction": "${direction}",
  "changed_files": [${changedJson}],
  "affected_features": [${featJson}],
  "summary": "${commitMsg}"
}
"@

Set-Content -Path $triggerFile -Value $json -Encoding UTF8
exit 0
