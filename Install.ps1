<#
	.SYNOPSIS
	A PowerShell script that automates configuring Mozilla Firefox

	Copyright (c) 2023 lowl1f3

	.LINK GitHub
	https://github.com/lowl1f3/Firefox

	.LINK Telegram
	https://t.me/lowlif3

	.LINK Discord
	https://discord.com/users/330825971835863042

	.LINK Author
	https://github.com/lowl1f3
#>

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$Script:DownloadsFolder = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}"

# Download MicaForEveryone
Write-Verbose -Message "Downloading MicaForEveryone..." -Verbose

# https://github.com/MicaForEveryone/MicaForEveryone
$Parameters = @{
	Uri             = "https://github.com/MicaForEveryone/MicaForEveryone/releases/latest/download/MicaForEveryone-x64-Release-Installer.exe"
	OutFile         = "$DownloadsFolder\MicaForEveryone-x64-Release-Installer.exe"
	UseBasicParsing = $true
	Verbose         = $true
}
Invoke-WebRequest @Parameters

Start-Process -FilePath "$DownloadsFolder\MicaForEveryone-x64-Release-Installer.exe"
