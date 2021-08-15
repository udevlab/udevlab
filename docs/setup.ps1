
$url = "https://github.com/indygreg/python-build-standalone/releases/download/20210724/cpython-3.9.6-x86_64-pc-windows-msvc-shared-install_only-20210724T1424.tar.gz"

Write-Output "Downloading standalone portable python ..."
$tempFolderPath = Join-Path $Env:Temp $(New-Guid)
New-Item -Type Directory -Path $tempFolderPath | Out-Null

$output = "$tempFolderPath\python.tar.gz"

(New-Object System.Net.WebClient).DownloadFile($url, $output)

tar -C $tempFolderPath -xf $output

$currentDir = Get-Location

if (Test-Path "setup\__main2__.py") {
    Write-Output "Running from local directory"
} else {
    $url = "https://github.com/indygreg/python-build-standalone/releases/download/20210724/cpython-3.9.6-x86_64-pc-windows-msvc-shared-install_only-20210724T1424.tar.gz"
    (New-Object System.Net.WebClient).DownloadFile("https://github.com/udevlab/udevlab/archive/refs/heads/main.zip", "$tempFolderPath\main.zip")
    Expand-Archive -LiteralPath "$tempFolderPath\main.zip" -DestinationPath $tempFolderPath\main
    Set-Location -Path  $tempFolderPath\main\udevlab-main
}

& $tempFolderPath\python\python -m setup

Set-Location -Path $currentDir

Remove-Item -Recurse -Force $tempFolderPath
