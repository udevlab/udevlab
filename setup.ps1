
$python_url = "https://github.com/indygreg/python-build-standalone/releases/download/20210724/cpython-3.9.6-x86_64-pc-windows-msvc-shared-install_only-20210724T1424.tar.gz"
$archive_url = "https://github.com/udevlab/udevlab/archive/refs/heads/main.zip"
$achive_path = "main\udevlab-main"

# Create temp directory
$tempFolderPath = Join-Path $Env:Temp $(New-Guid)
New-Item -Type Directory -Path $tempFolderPath | Out-Null

$python_path = $env:USERPROFILE
@( ".udevlab", "python3.9.6-0" ) | ForEach-Object{ $python_path = Join-Path $python_path $_ }

# Download and extract portable python if not found
if (!(Test-Path $python_path)) {
    $output = "$tempFolderPath\python.tar.gz"
    Write-Output "Downloading standalone portable python ..."
    (New-Object System.Net.WebClient).DownloadFile($python_url, $output)
    tar -C $tempFolderPath -xf $output
    $download_python_path = Join-Path $tempFolderPath "python"
    New-Item -Type Directory -Path $python_path | Out-Null
    Move-Item -Path $download_python_path\* -Destination $python_path
}

$currentDir = Get-Location

# Check if running from source directory
if (Test-Path "setup\__main__.py") {
    Write-Output "Running from local directory"
} else {
    $main_zip = "$tempFolderPath\main.zip"
    (New-Object System.Net.WebClient).DownloadFile($archive_url, $main_zip)
    Expand-Archive -LiteralPath "$main_zip -DestinationPath $tempFolderPath\main"
    Set-Location -Path  $tempFolderPath\$achive_path
}

& $python_path\python -m setup
Set-Location -Path $currentDir

Remove-Item -Recurse -Force $tempFolderPath
