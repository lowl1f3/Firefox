<#
	.SYNOPSIS
	A PowerShell script that automates customizing Mozilla Firefox

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

# Check if Mozilla Firefox is installed
if (-not (Test-Path -Path "$env:APPDATA\Mozilla\Firefox"))
{
	Write-Warning -Message "Mozilla Firefox isn't installed. Install it and re-run the script again."
	break
}

# Get default profile name
$String = (Get-Content -Path "$env:APPDATA\Mozilla\Firefox\installs.ini" | Select-String -Pattern "^\s*Default\s*=\s*.+" | ConvertFrom-StringData).Default
$ProfileName = Split-Path -Path $String -Leaf

# Check if a chrome folder exsists
if (-not (Test-Path -Path $env:APPDATA\Mozilla\Firefox\Profiles\$ProfileName\chrome))
{
	New-Item -Path "$env:APPDATA\Mozilla\Firefox\Profiles\$ProfileName\chrome" -ItemType Directory -Force
	New-Item -Path "$env:APPDATA\Mozilla\Firefox\Profiles\$ProfileName\chrome\image" -ItemType Directory -Force
}

# Download .css files
if (Test-Path -Path "$env:APPDATA\Mozilla\Firefox\Profiles\$ProfileName\chrome")
{
	$Files = @(
		# https://github.com/lowl1f3/Firefox/blob/main/chrome/cleaner_extensions_menu.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/cleaner_extensions_menu.css",

		# https://github.com/lowl1f3/Firefox/blob/main/chrome/give_more_width_to_active_tab.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/give_more_width_to_active_tab.css",

		# https://github.com/lowl1f3/Firefox/blob/main/chrome/hide_list-all-tabs_button.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/hide_list-all-tabs_button.css",

		# https://github.com/lowl1f3/Firefox/blob/main/chrome/icons_in_main_menu.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/icons_in_main_menu.css",

		# https://github.com/lowl1f3/Firefox/blob/main/chrome/min-max-close_buttons.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/min-max-close_buttons.css",

		# https://github.com/lowl1f3/Firefox/blob/main/chrome/no_search_engines_in_url_bar.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/no_search_engines_in_url_bar.css",

		# https://github.com/lowl1f3/Firefox/blob/main/chrome/privacy_blur_email_in_main_menu.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/privacy_blur_email_in_main_menu.css",

		# https://github.com/lowl1f3/Firefox/blob/main/chrome/privacy_blur_email_in_sync_menu.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/privacy_blur_email_in_sync_menu.css",

		# https://github.com/lowl1f3/Firefox/blob/main/chrome/remove_homepage_shortcut_title_text.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/remove_homepage_shortcut_title_text.css",

		# https://github.com/lowl1f3/Firefox/blob/main/chrome/transparent_bookmarks_bar.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/transparent_bookmarks_bar.css",

		# https://github.com/lowl1f3/Firefox/blob/main/chrome/ublock-icon-change.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/ublock-icon-change.css",

		# https://github.com/lowl1f3/Firefox/blob/main/chrome/userChrome.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/userChrome.css",

		# https://github.com/lowl1f3/Firefox/blob/main/chrome/userContent.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/userContent.css"
	)

	Write-Warning -Message "Downloading .css files..."

	# Loop
	foreach ($File in $Files)
	{
		Write-Information -MessageData "" -InformationAction Continue
		Write-Verbose -Message $(Split-Path -Path $File -Leaf) -Verbose

		if ($(Split-Path -Path $File -Leaf))
		{
			$Parameters = @{
				Uri             = $File
				OutFile         = "$env:APPDATA\Mozilla\Firefox\Profiles\$ProfileName\chrome\$(Split-Path -Path $File -Leaf)"
				UseBasicParsing = $true
			}
		}
		Invoke-Webrequest @Parameters
	}

	if (Test-Path -Path "$env:APPDATA\Mozilla\Firefox\Profiles\$ProfileName\chrome\image")
	{
		$Images = @(
			# Firefox_2019.svg
			"https://github.com/lowl1f3/Firefox/blob/main/chrome/image/Firefox_2019.svg",

			# about-logo-private-changed.png
			"https://github.com/lowl1f3/Firefox/blob/main/chrome/image/about-logo-private-changed.png",

			# browser-firefox.svg
			"https://github.com/lowl1f3/Firefox/blob/main/chrome/image/browser-firefox.svg",

			# files.svg
			"https://github.com/lowl1f3/Firefox/blob/main/chrome/image/files.svg",

			# firefox.svg
			"https://github.com/lowl1f3/Firefox/blob/main/chrome/image/firefox.svg",

			# firefoxx.png
			"https://github.com/lowl1f3/Firefox/blob/main/chrome/image/firefoxx.png",

			# left-arrow.svg
			"https://github.com/lowl1f3/Firefox/blob/main/chrome/image/left-arrow.svg",

			# noise-512x512.png
			"https://github.com/lowl1f3/Firefox/blob/main/chrome/image/noise-512x512.png",

			# right-arrow.svg
			"https://github.com/lowl1f3/Firefox/blob/main/chrome/image/right-arrow.svg",

			# search-glass.svg
			"https://github.com/lowl1f3/Firefox/blob/main/chrome/image/search-glass.svg",

			# stack.svg
			"https://github.com/lowl1f3/Firefox/blob/main/chrome/image/stack.svg"
		)

		Write-Warning -Message "Downloading images..."

		# Loop
		foreach ($Image in $Images)
		{
			Write-Information -MessageData "" -InformationAction Continue
			Write-Verbose -Message $(Split-Path -Path $Image -Leaf) -Verbose

			if ($(Split-Path -Path $Image -Leaf))
			{
				$Parameters = @{
					Uri             = $Image
					OutFile         = "$env:APPDATA\Mozilla\Firefox\Profiles\$ProfileName\chrome\image\$(Split-Path -Path $Image -Leaf)"
					UseBasicParsing = $true
				}
			}
			Invoke-Webrequest @Parameters
		}
	}
}
