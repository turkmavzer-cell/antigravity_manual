# SessionStart Hook: Aktif modeli ve açık projenin bağlantı durumunu ajana bildirir (antigravity_manual).
$ErrorActionPreference = "SilentlyContinue"
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

try {
    $rawInput = [Console]::In.ReadToEnd()
    if ([string]::IsNullOrWhiteSpace($rawInput)) {
        Write-Output "{}"
        exit 0
    }

    $payload = $rawInput | ConvertFrom-Json
    $modelName = if ($payload.modelName) { [string]$payload.modelName } else { "bilinmiyor" }

    $pluginJsonPath = Join-Path (Split-Path -Parent $PSScriptRoot) "plugin.json"
    $ver = "1.0.0"
    if (Test-Path $pluginJsonPath) {
        $pObj = Get-Content $pluginJsonPath -Raw -Encoding UTF8 | ConvertFrom-Json
        if ($pObj.version) { $ver = $pObj.version }
    }

    $msgParts = @()
    $msgParts += "[antigravity_manual v$ver] Başlangıç modeli: '$modelName' (Son USER_SETTINGS_CHANGE varsa o geçerlidir). Uzun onay kutusu YASAKTIR. Basit soru/bilgi/işlemde Hydrogen (veya Flash) aktifse HİÇ SORMADAN doğrudan yap/cevapla; Argon aktifse araç çağırmadan 2 cümleyle Hydrogen'e geçmeyi öner. Kapsamlı araştırma/planlamada Argon aktifse SORMADAN kapsamlı planı hazırlayıp bitir ve sonunda 'Plan tamamlandı. Hydrogen'e geçip devam edebilir ya da Argon'dan devam edebilirsin.' yaz; Hydrogen aktifse 2 cümleyle planlama için Argon'a geçmeyi öner."

    $cleanWorkspaces = @()
    if ($payload.workspacePaths -and $payload.workspacePaths.Count -gt 0) {
        foreach ($ws in $payload.workspacePaths) {
            if (-not [string]::IsNullOrWhiteSpace($ws)) {
                $cleanPath = $ws -replace '^file:///', '' -replace '/', '\'
                $cleanPath = [System.Uri]::UnescapeDataString($cleanPath)
                if ($cleanPath -match '^[a-z]:\\') {
                    $cleanPath = $cleanPath.Substring(0,1).ToUpper() + $cleanPath.Substring(1)
                }
                $cleanWorkspaces += $cleanPath
                $projectLearningFile = Join-Path $cleanPath ".agents\learnings\PROJECT.md"
                if ((Test-Path $cleanPath) -and (-not (Test-Path $projectLearningFile))) {
                    $msgParts += "Açık proje ('$cleanPath') henüz sisteme bağlı değil; uygun bir anda 'projeyi bağla' komutunu hatırlat."
                } elseif (Test-Path $projectLearningFile) {
                    $msgParts += "Açık proje ('$cleanPath') sisteme bağlı; '.agents/learnings/PROJECT.md' dosyasındaki projeye özel öğrenimleri dikkate al."
                }
            }
        }
    }

    $modesPath = Join-Path (Split-Path -Parent $PSScriptRoot) "projects\modes.json"
    if (Test-Path $modesPath) {
        $modes = Get-Content $modesPath -Raw -Encoding UTF8 | ConvertFrom-Json
        $coord = $modes.multiRepoCoordinator
        $hasCoord = ($cleanWorkspaces | Where-Object { $_ -match $coord }).Count -gt 0
        $otherRepos = @($cleanWorkspaces | Where-Object { $_ -notmatch $coord })
        if ($hasCoord -and $otherRepos.Count -gt 0) {
            $targetList = $otherRepos -join ", "
            $msgParts += "OTOMATİK ÇİFT REPO MODU AKTİF: '$coord' yönetiminde '$targetList' reposu yönetilir."
        } elseif ($cleanWorkspaces.Count -eq 0 -and (Test-Path $modes.defaultScratchRule)) {
            $msgParts += "VARSAYILAN ORTAK PROJE MODU: '$($modes.defaultScratchRule)' kuralları ve '$($modes.defaultManagedRepo)' geçerlidir."
        }
    }

    $fullMessage = $msgParts -join " "
    $response = @{
        injectSteps = @(
            @{
                systemMessage = @{
                    systemMessage = $fullMessage
                }
            }
        )
    }

    $jsonOut = $response | ConvertTo-Json -Depth 6 -Compress
    # ASCII dışı karakterleri \uXXXX olarak kaçır ki PowerShell/konsol kodlaması ne olursa olsun Türkçe karakterler asla bozulmasın
    $sb = New-Object System.Text.StringBuilder
    foreach ($ch in $jsonOut.ToCharArray()) {
        $code = [int][char]$ch
        if ($code -gt 127) {
            [void]$sb.AppendFormat("\u{0:x4}", $code)
        } else {
            [void]$sb.Append($ch)
        }
    }
    Write-Output $sb.ToString()
} catch {
    Write-Output "{}"
}
exit 0