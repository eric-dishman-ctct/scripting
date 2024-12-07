$fileExtension = ".txt"

switch ($fileExtension) {
    { ".txt", ".json" -eq $_ } {
        Write-Output "This is a text or JSON file."
    }
    .xml {
        Write-Output "This is an XML file."
    }
    default {
        Write-Output "Unknown file type."
    }
}

