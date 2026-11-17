param(
    [string]$Message = "docs(learnings): öğrenimleri senkronize et",
    [string]$TargetFile = ""
)

$ErrorActionPreference = "Continue"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$repo = Split-Path -Parent $PSScriptRoot
Set-Location $repo
$logFile = Join-Path $repo ".sync.log"

if (-not [string]::IsNullOrWhiteSpace($TargetFile) -and (Test-Path $TargetFile)) {
    git add -- $TargetFile 2>&1 | Out-Null
} else {
    git add -A 2>&1 | Out-Null
}

$changes = git status --porcelain
if ($changes) {
    $commitOut = git commit -m $Message 2>&1
    if ($LASTEXITCODE -ne 0) {
        "$(Get-Date -Format o) COMMIT_FAILED: $commitOut" | Out-File $logFile -Append -Encoding UTF8
        Write-Output "COMMIT_FAILED: $commitOut"
        exit 1
    }
}

$pullOut = git pull --rebase origin main 2>&1
if ($LASTEXITCODE -ne 0) {
    git rebase --abort 2>&1 | Out-Null
    "$(Get-Date -Format o) REBASE_CONFLICT_ABORTED: $pullOut" | Out-File $logFile -Append -Encoding UTF8
    Write-Output "REBASE_CONFLICT_ABORTED: $pullOut"
    exit 1
}

$pushOut = git push -u origin main 2>&1
if ($LASTEXITCODE -ne 0) {
    "$(Get-Date -Format o) PUSH_FAILED: $pushOut" | Out-File $logFile -Append -Encoding UTF8
    Write-Output "PUSH_FAILED: $pushOut"
    exit 1
}

"$(Get-Date -Format o) SYNC_OK: $Message" | Out-File $logFile -Append -Encoding UTF8
Write-Output "SYNC_OK"
exit 0