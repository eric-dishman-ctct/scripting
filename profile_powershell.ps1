$p = 0
1..100 | ForEach-Object {
    Write-Progress -Id 1 -Activity 'pwsh' -PercentComplete $_
    $p += (Measure-Command {
        pwsh -noprofile -command 1
    }).TotalMilliseconds
}
Write-Progress -id 1 -Activity 'profile' -Completed
$p = $p/100
$p

$a = 0
1..100 | ForEach-Object {
    Write-Progress -Id 1 -Activity 'profile' -PercentComplete $_
    $a += (Measure-Command {
        pwsh -command 1
    }).TotalMilliseconds
}
Write-Progress -id 1 -activity 'profile' -Completed
$a/100 - $p
