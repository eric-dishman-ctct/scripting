Param(
[string]$local,
[string]$remote
)

# Get the file extension
$extension = [System.IO.Path]::GetExtension($local).ToLower()

switch ($extension) {
        { ".slx", ".mdl", ".mlx" -eq $_ }{
                # Use MATLAB's Comparison Tool
                & "C:\Program Files\MATLAB\R2021b\bin\win64\mlDiff.exe" $local $remote
                break
            }
        { ".m", ".txt", ".md", ".lua", ".ps1" -eq $_ }{
                # Use Neovim's diff mode
                & nvim -d $local $remote
                break
        }
        default{
                # Fallback to default diff tool
                & diff $local $remote
                break
            }
}
