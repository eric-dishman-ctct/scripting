param (

    [string]$FileName
)

if (-not $FileName) {
    Write-Host "Error: A file name must be set, e.g. on 'the wonderful thing about tiggers'."
    exit 1
}

$FileName = $FileName -replace ' ', '-'
$FormattedFileName = (Get-Date -Format 'yyyyMMddHHmmss') + "-${FileName}.md"
Set-Location "$HOME\DishVault" -ErrorAction Stop
New-Item -ItemType File -Path "inbox\${FormattedFileName}" -Force
nvim "inbox\${FormattedFileName}"
