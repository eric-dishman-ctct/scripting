# Create a temporary file to store the output
$tempFile = [System.IO.Path]::GetTempFileName()

# Collect duplicate lines
$duplicates = Get-ChildItem -Path . -Filter "*.m" | 
ForEach-Object { 
    $filePath = $_.FullName
    $lineNumber = 1
    Get-Content $filePath | 
    Where-Object { $_.Trim() -ne "" } |  # Ignore empty lines
    ForEach-Object { 
        [PSCustomObject]@{
            FilePath = $filePath
            Line = $_.Trim()
            LineNumber = $lineNumber++
            OriginalOrder = $lineNumber
        }
    } 
} |
Group-Object Line |  # Group identical lines
Where-Object { $_.Count -gt 1 } |  # Filter groups with more than one occurrence
ForEach-Object { 
    $_.Group | Sort-Object { $_.FilePath }, { $_.LineNumber } | ForEach-Object { 
        [PSCustomObject]@{
            Line = $_.Line
            FilePath = "$($_.FilePath):$($_.LineNumber)"
            LineNumber = $_.LineNumber
        }
    }
}

# Write the main output to the temporary file with Unix-style line endings
$duplicates |
Sort-Object LineNumber |  # Sort the final output by line number
Format-Table -Wrap -AutoSize | Out-String | ForEach-Object { $_ -replace "`r`n", "`n" } | Set-Content -Path $tempFile

# Append the duplicate code snippets to the end of the file with Unix-style line endings
Add-Content -Path $tempFile -Value "`nDuplicate Code Snippets:`n"
$duplicates |
Group-Object Line |  # Group by line to avoid double entries
ForEach-Object { $_.Name } |  # Get unique lines
ForEach-Object { Add-Content -Path $tempFile -Value ($_ -replace "`r`n", "`n") }

# Open the temporary file in Neovim
nvim $tempFile

