# Set the root folder to start the search
$rootFolder = "C:\Users\50012116\Desktop\Mahindra\All_scripts"

# Set the output file paths
$successLog = "$rootFolder\success_log.txt"
$failureLog = "$rootFolder\failure_log.txt"

# Initialize arrays to hold success and failure paths
$successList = @()
$failureList = @()

# Get all vuser_init.c files recursively
$files = Get-ChildItem -Path $rootFolder -Recurse -Filter "vuser_init.c" -File

# Filter out files whose parent folder is named 'data'
$filteredFiles = $files | Where-Object {
    $_.Directory.Name -ne "data"
}

# Loop through each file and attempt to replace the IP
foreach ($file in $filteredFiles) {
    try {
        $content = Get-Content -Path $file.FullName -Raw
        if ($content -match "10\.218\.4\.172") {
            $newContent = $content -replace "10\.218\.4\.172", "10.251.22.99"
            Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
            $successList += $file.FullName
        } else {
            # IP not found, consider as failure
            $failureList += $file.FullName
        }
    } catch {
        # Any error during read/write
        $failureList += $file.FullName
    }
}

# Write logs
$successList | Out-File -FilePath $successLog -Encoding UTF8
$failureList | Out-File -FilePath $failureLog -Encoding UTF8

Write-Host "✅ Replacement completed."
#Write-Host "✔ Success log saved to: $successLog"
#Write-Host "❌ Failure log saved to: $failureLog"

