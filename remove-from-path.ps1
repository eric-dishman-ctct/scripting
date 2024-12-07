param
(
    [Parameter()]
    [string]$Path
)

if ([string]::IsNullOrWhiteSpace($Path))
{
        Write-Host ""
        Write-Host "-Path argument is empty"
        Write-Host ""
        Write-Host "Please call this script like this example:"
        Write-Host ".\remove-from-path.ps1 -Path ""Path\To\Remove"""
        Write-Host ""

        Pause
        Exit
}

$CurrentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
$NewPath = $CurrentPath -replace [regex]::Escape($Path), ""
[System.Environment]::SetEnvironmentVariable("Path", "$NewPath", "User")

