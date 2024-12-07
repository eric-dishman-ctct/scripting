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
        Write-Host ".\add-to-path.ps1 -Path ""Path\To\Add"""
        Write-Host ""

        Pause
        Exit
}

$CurrentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
[System.Environment]::SetEnvironmentVariable("Path", "$CurrentPath;$Path", "User")

