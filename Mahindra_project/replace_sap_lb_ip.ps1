# Set the root folder (current directory)
$rootFolder = Get-Location

# Set the output file paths
$allPathsFile = "$rootFolder\lr_strings_paths.txt"
$successLog = "$rootFolder\successfully_modified.txt"
$failureLog = "$rootFolder\modification_failed.txt"

# Clear previous logs if they exist
Remove-Item -Path $successLog, $failureLog -ErrorAction SilentlyContinue

# Find all matching files
$files = Get-ChildItem -Path $rootFolder -Recurse -Filter "lr_strings.h" -File

# Save all file paths
$files | Select-Object -ExpandProperty FullName | Out-File -FilePath $allPathsFile -Encoding UTF8

# Define the old and new IP strings
$oldIP = "10.218.228.13"
$newIP = "10.251.22.80"

foreach ($file in $files) {
    $parentFolder = Split-Path $file.DirectoryName -Leaf

    # Skip files in 'data' folders
    if ($parentFolder -ne "data") {
        try {
            $content = Get-Content $file.FullName -Raw

            if ($content -match [regex]::Escape($oldIP)) {
                $updatedContent = $content -replace [regex]::Escape($oldIP), $newIP
                Set-Content -Path $file.FullName -Value $updatedContent -Encoding UTF8
                Add-Content -Path $successLog -Value $file.FullName
            } else {
                Add-Content -Path $failureLog -Value "$($file.FullName) - IP not found"
            }
        } catch {
            Add-Content -Path $failureLog -Value "$($file.FullName) - Error: $_"
        }
    }
}

Write-Host "Script completed."
Write-Host "Modified files logged in: $successLog"
Write-Host "Failures logged in: $failureLog"
