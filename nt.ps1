Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install -y unzip zip
choco install -y wget curl
choco install -y imagemagick.app ffmpeg yt-dlp

winget install eza-community.eza
winget install -e --id Git.Git
winget install -e --id Microsoft.WindowsTerminal
