Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

function Escape-ForJson {
  param([string]$Value)
  if ($null -eq $Value) { return "" }
  return $Value.Replace('\', '\\').Replace('"', '\"').Replace("`r", '\r').Replace("`n", '\n').Replace("`t", '\t')
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$pluginRoot = Split-Path -Parent $scriptDir

$projectRoot = $PWD.Path
if ($env:CURSOR_WORKSPACE_ROOT) {
  $projectRoot = $env:CURSOR_WORKSPACE_ROOT
} elseif ($env:WORKSPACE_ROOT) {
  $projectRoot = $env:WORKSPACE_ROOT
}

$projectConfig = Join-Path $projectRoot ".specflow/plugin.config.json"
$enabled = $true
$integrationMode = "complement-superpowers"
$disableSuperpowers = $false

if (Test-Path $projectConfig) {
  $content = Get-Content -Raw -Path $projectConfig -Encoding UTF8
  if ($content -match '"enabled"\s*:\s*false') {
    $enabled = $false
  }
  if ($content -match '"integrationMode"\s*:\s*"specflow-only"') {
    $integrationMode = "specflow-only"
  }
  if ($content -match '"disableSuperpowers"\s*:\s*true') {
    $disableSuperpowers = $true
  }
}

if (-not $enabled) {
  $sessionContext = @"
<IMPORTANT>
SpecFlow plugin is disabled by project config at .specflow/plugin.config.json (enabled=false). Do not trigger SpecFlow skills automatically in this session.
</IMPORTANT>
"@
} else {
  $requiredSpecflowPaths = @(
    ".specflow/CONSTITUTION.md",
    ".specflow/RULES.md",
    ".specflow/docs/PRD.md",
    ".specflow/docs/NFR.md",
    ".specflow/memory/progress.md"
  )
  $missingSpecflowPaths = @()
  foreach ($rel in $requiredSpecflowPaths) {
    $abs = Join-Path $projectRoot $rel
    if (-not (Test-Path $abs)) {
      $missingSpecflowPaths += $rel
    }
  }
  $needsInitialization = ($missingSpecflowPaths.Count -gt 0)
  $initGuard = ""
  if ($needsInitialization) {
    $missingJoined = [string]::Join(", ", $missingSpecflowPaths)
    $initGuard = "INITIALIZATION HARD GATE: SpecFlow documents are not initialized yet. Missing required files: $missingJoined. For any requirement/feature/implementation/acceptance request (including plain natural language, not only /specflow command), run specflow-initialize-project first. Do not treat docs/superpowers/specs or docs/superpowers/plans as substitutes for .specflow PRD/SPEC/ACCEPTANCE."
  } else {
    $initGuard = "SpecFlow initialization check passed: required .specflow core files are present."
  }

  $skillPath = Join-Path $pluginRoot "skills/specflow-session-bootstrap/SKILL.md"
  if (Test-Path $skillPath) {
    $skillContent = Get-Content -Raw -Path $skillPath -Encoding UTF8
  } else {
    $skillContent = "Error reading specflow-session-bootstrap skill"
  }

  if ($integrationMode -eq "specflow-only") {
    $sessionContext = @"
<EXTREMELY_IMPORTANT>
SpecFlow plugin is active in SPECFLOW-ONLY mode.

Use SpecFlow skills as the default workflow in this project.
$initGuard

Start from specflow-session-bootstrap and follow the relevant SpecFlow skills by task phase.

$skillContent
</EXTREMELY_IMPORTANT>
"@
  } else {
    $superpowersRule = "When both are installed, use both. Resolve overlap by keeping Superpowers for process and SpecFlow for scope/acceptance."
    if ($disableSuperpowers) {
      $superpowersRule = "Project config requests Superpowers OFF for this project. Do not invoke Superpowers skills unless user explicitly asks."
    }

    $sessionContext = @"
<EXTREMELY_IMPORTANT>
SpecFlow plugin is active in COMPLEMENT-SUPERPOWERS mode.

Compatibility rule:
1) Superpowers skills define process discipline (how to execute).
2) SpecFlow skills define source-of-truth scope and acceptance gates (what to deliver).
3) $superpowersRule
$initGuard

Start with specflow-session-bootstrap whenever the user intent involves requirements, acceptance, or archive lifecycle.

$skillContent
</EXTREMELY_IMPORTANT>
"@
  }
}

$escaped = Escape-ForJson $sessionContext
Write-Output "{`n  `"additional_context`": `"$escaped`"`n}"
