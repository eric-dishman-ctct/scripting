try{
    Write-Host "Enter try"
    Stop-Komorebi
    Write-Host "Exit try"
}
finally{
    Write-Host "Enter finally"
    Start-Komorebi
    Write-Host "Exit finally"
}

function Start-Komorebi{
    komorebic start --whkd
# Start hidden PowerShell script, which runs `zebar open bar --args ...` for every monitor.

# Retrieve the list of monitors
$monitors = zebar monitors

# Iterate over each monitor and run the `zebar open bar --args ...` command
foreach ($monitor in $monitors) {
    Start-Process -WindowStyle Hidden -FilePath "zebar" -ArgumentList "open bar --args $monitor"
}
    }
function Stop-Komorebi{
        Write-Output "Stopping Komorebi"
        komorebic stop
        Write-Output "Stopped"
        Write-Output "Stopping whkd"
        Stop-Process -Name whkd
        Write-Output "Stopped"
        Write-Output "Stopping Zebar"
        Stop-Process -Name zebar
        Write-Output "Stopped"

    }
