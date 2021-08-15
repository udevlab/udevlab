
$python_url = "https://github.com/indygreg/python-build-standalone/releases/download/20210724/cpython-3.9.6-x86_64-pc-windows-msvc-shared-install_only-20210724T1424.tar.gz"
$archive_url = "https://github.com/udevlab/udevlab/archive/refs/heads/main.zip"
$achive_path = "main\udevlab-main"


$tempFolderPath = Join-Path $Env:Temp $(New-Guid)
New-Item -Type Directory -Path $tempFolderPath | Out-Null

$output = "$tempFolderPath\python.tar.gz"
Write-Output "Downloading standalone portable python ..."
(New-Object System.Net.WebClient).DownloadFile($python_url, $output)
tar -C $tempFolderPath -xf $output

$currentDir = Get-Location

if (Test-Path "setup\__main__.py") {
    Write-Output "Running from local directory"
} else {
    $main_zip = "$tempFolderPath\main.zip"
    (New-Object System.Net.WebClient).DownloadFile($archive_url, $main_zip)
    Expand-Archive -LiteralPath "$main_zip -DestinationPath $tempFolderPath\main
    Set-Location -Path  $tempFolderPath\$achive_path
}

& $tempFolderPath\python\python -m setup

Set-Location -Path $currentDir

Remove-Item -Recurse -Force $tempFolderPath
