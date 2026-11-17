# PostToolUse Hook: Core repodaki learnings/*.md veya projects/REGISTRY.md değiştiğinde senkron olarak GitHub'a gönderir.
$ErrorActionPreference = "SilentlyContinue"
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

try {
    $rawInput = [Console]::In.ReadToEnd()
    if (-not [string]::IsNullOrWhiteSpace($rawInput)) {
        $payload = $rawInput | ConvertFrom-Json
        $argsObj = $payload.toolCall.args
        $targetPath = $null
        if ($argsObj.Path) {
            $targetPath = [string]$argsObj.Path
        } elseif ($argsObj.TargetFile) {
            $targetPath = [string]$argsObj.TargetFile
        }

        if (-not [string]::IsNullOrWhiteSpace($targetPath)) {
            $normalized = $targetPath.Replace('/', '\').ToLowerInvariant()
            if ($normalized -match 'antigravity_manual\\(learnings\\[^\\]+\.md|projects\\registry\.md)$') {
                $leaf = Split-Path -Leaf $targetPath
                $syncScript = Join-Path $PSScriptRoot "sync.ps1"
                $commitMsg = "docs(learnings): otomatik senkronizasyon ($leaf)"
                & powershell -NoProfile -ExecutionPolicy Bypass -File $syncScript -Message $commitMsg -TargetFile $targetPath | Out-Null
            }
        }
    }
} catch {
    # Hata durumunda ajanı bloklama
}

Write-Output "{}"
exit 0