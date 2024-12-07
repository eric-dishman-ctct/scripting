# Define the parent directories and the target base folder
$parentDirectories = @(
"\\acgfs01\sharesac\CTCT_Data\StateEstValData\MG\140M3\07_19_2018",
"\\acgfs01\sharesac\CTCT_Data\StateEstValData\MG\140M3\07_19_2018_2",
"\\acgfs01\sharesac\CTCT_Data\StateEstValData\MG\140M3\07_20_2018",
"\\acgfs01\sharesac\CTCT_Data\StateEstValData\MG\140M3\07_25_2018",
"\\acgfs01\sharesac\CTCT_Data\StateEstValData\MG\140M3\07_25_2018_1",
"\\acgfs01\sharesac\CTCT_Data\StateEstValData\MG\140M3\07_25_2018_2",
"\\acgfs01\sharesac\CTCT_Data\StateEstValData\MG\140M3\07_26_2018_1",
"\\acgfs01\sharesac\CTCT_Data\StateEstValData\MG\140M3\07_26_2018_2_TA_Cal",
"C:\ParentFolder2", "C:\ParentFolder3")  # Adjust as needed
$targetBase = "F:\data\mg"  # The base destination path

# Loop through each parent directory and copy files while maintaining the relative paths
foreach ($parent in $parentDirectories) {
    # Get the relative path of the parent folder in the backup destination
    $parentFolderName = Split-Path $parent -Leaf
    $destinationPath = Join-Path $targetBase $parentFolderName

    # Recursively copy files from the parent folder to the destination, preserving structure
    Get-ChildItem -Path $parent -Recurse | ForEach-Object {
        $relativePath = $_.FullName.Substring($parent.Length)
        $destinationFullPath = Join-Path $destinationPath $relativePath

        if (-not (Test-Path (Split-Path $destinationFullPath -Parent))) {
            # Create directory if it doesn't exist
            New-Item -Path (Split-Path $destinationFullPath -Parent) -ItemType Directory -Force
        }

        # Copy file or directory
        if ($_.PSIsContainer) {
            # If it's a folder, ensure it exists in the destination
            New-Item -Path $destinationFullPath -ItemType Directory -Force
        } else {
            # If it's a file, copy it
            Copy-Item -Path $_.FullName -Destination $destinationFullPath -Force
        }
    }

    Write-Host "Copied content from $parent to $destinationPath"
}

