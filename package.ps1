$ErrorActionPreference = 'Stop'
$taskDist = Join-Path $PSScriptRoot 'dist'
$taskPackage = Join-Path $taskDist 'Endfield-HideUID-v1.0.0'
New-Item -ItemType Directory -Path (Join-Path $taskPackage 'HideUID') -Force | Out-Null
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'HideUID\mod.ini') -Destination (Join-Path $taskPackage 'HideUID\mod.ini') -ErrorAction Stop
foreach ($taskFile in @('README.md','LICENSE')) {
    Copy-Item -LiteralPath (Join-Path $PSScriptRoot $taskFile) -Destination $taskPackage -ErrorAction Stop
}
$taskHash = (Get-FileHash -LiteralPath (Join-Path $taskPackage 'HideUID\mod.ini') -Algorithm SHA256).Hash.ToLowerInvariant()
"$taskHash  HideUID/mod.ini" | Set-Content -LiteralPath (Join-Path $taskPackage 'SHA256SUMS.txt') -Encoding ascii
$taskZip = Join-Path $taskDist 'Endfield-HideUID-v1.0.0-EFMI.zip'
Compress-Archive -LiteralPath $taskPackage -DestinationPath $taskZip -Force
$taskArchive = [IO.Compression.ZipFile]::OpenRead($taskZip)
try {
    $taskEntries = @($taskArchive.Entries | Where-Object { $_.Name } | ForEach-Object { $_.FullName.Replace('\','/') })
    $taskExpected = @('Endfield-HideUID-v1.0.0/HideUID/mod.ini','Endfield-HideUID-v1.0.0/README.md','Endfield-HideUID-v1.0.0/LICENSE','Endfield-HideUID-v1.0.0/SHA256SUMS.txt')
    if (Compare-Object $taskExpected $taskEntries) { throw 'Unexpected file in release ZIP.' }
} finally { $taskArchive.Dispose() }
[pscustomobject]@{ ZIP = $taskZip; ZIPBytes = (Get-Item -LiteralPath $taskZip).Length; INI_SHA256 = $taskHash }
