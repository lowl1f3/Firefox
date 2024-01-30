<#
	.SYNOPSIS
	A PowerShell script that automates customizing Mozilla Firefox

	Copyright (c) 2024 lowl1f3

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

if ($Host.Version.Major -eq 5) {
	# Progress bar can significantly impact cmdlet performance
	# https://github.com/PowerShell/PowerShell/issues/2138
	$Script:ProgressPreference = "SilentlyContinue"
}

$Script:DownloadsFolder = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}"

# Check if Mozilla Firefox is installed
if (-not (Test-Path -Path "$env:APPDATA\Mozilla\Firefox")) {
	Write-Warning -Message "Mozilla Firefox isn't installed. Install it and re-run the script/function again."
	break
}

# Get default profile name
# https://github.com/farag2/Mozilla-Firefox/blob/master/Configure_Firefox.ps1#L5
$String = (Get-Content -Path "$env:APPDATA\Mozilla\Firefox\installs.ini" | Select-String -Pattern "^\s*Default\s*=\s*.+" | ConvertFrom-StringData).Default
$ProfileName = Split-Path -Path $String -Leaf

# Check if a chrome folder exsists
if (-not (Test-Path -Path $env:APPDATA\Mozilla\Firefox\Profiles\$ProfileName\chrome)) {
	New-Item -Path "$env:APPDATA\Mozilla\Firefox\Profiles\$ProfileName\chrome" -ItemType Directory -Force
	New-Item -Path "$env:APPDATA\Mozilla\Firefox\Profiles\$ProfileName\chrome\image" -ItemType Directory -Force
}

# Download .css files
if (Test-Path -Path "$env:APPDATA\Mozilla\Firefox\Profiles\$ProfileName\chrome")
{
	$Files = @(
		# bookmarks_bar_same_color_as_toolbar.css
		# https://github.com/lowl1f3/Firefox/blob/main/chrome/bookmarks_bar_same_color_as_toolbar.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/bookmarks_bar_same_color_as_toolbar.css",

		# cleaner_extensions_menu.css
		# https://github.com/lowl1f3/Firefox/blob/main/chrome/cleaner_extensions_menu.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/cleaner_extensions_menu.css",

		# colored_soundplaying_tab.css
		# https://github.com/lowl1f3/Firefox/blob/main/chrome/colored_soundplaying_tab.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/colored_soundplaying_tab.css",

		# hide_list-all-tabs_button.css
		# https://github.com/lowl1f3/Firefox/blob/main/chrome/hide_list-all-tabs_button.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/hide_list-all-tabs_button.css",

		# icons_in_main_menu.css
		# https://github.com/lowl1f3/Firefox/blob/main/chrome/icons_in_main_menu.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/icons_in_main_menu.css",

		# min-max-close_buttons.css
		# https://github.com/lowl1f3/Firefox/blob/main/chrome/min-max-close_buttons.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/min-max-close_buttons.css",

		# no_search_engines_in_url_bar.css
		# https://github.com/lowl1f3/Firefox/blob/main/chrome/no_search_engines_in_url_bar.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/no_search_engines_in_url_bar.css",

		# remove_homepage_shortcut_title_text.css
		# https://github.com/lowl1f3/Firefox/blob/main/chrome/remove_homepage_shortcut_title_text.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/remove_homepage_shortcut_title_text.css",

		# transparent_bookmarks_bar.css
		# https://github.com/lowl1f3/Firefox/blob/main/chrome/transparent_bookmarks_bar.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/transparent_bookmarks_bar.css",

		# ublock-icon-change.css
		# https://github.com/lowl1f3/Firefox/blob/main/chrome/ublock-icon-change.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/ublock-icon-change.css",

		# userChrome.css
		# https://github.com/lowl1f3/Firefox/blob/main/chrome/userChrome.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/userChrome.css",

		# userContent.css
		# https://github.com/lowl1f3/Firefox/blob/main/chrome/userContent.css
		"https://raw.githubusercontent.com/lowl1f3/Firefox/main/chrome/userContent.css"
	)

	Write-Warning -Message "Downloading .css files..."

	# Loop
	foreach ($File in $Files) {
		Write-Information -MessageData "" -InformationAction Continue
		Write-Verbose -Message $(Split-Path -Path $File -Leaf) -Verbose

		if ($(Split-Path -Path $File -Leaf)) {
			$Parameters = @{
				Uri             = $File
				OutFile         = "$env:APPDATA\Mozilla\Firefox\Profiles\$ProfileName\chrome\$(Split-Path -Path $File -Leaf)"
				UseBasicParsing = $true
			}
		}
		Invoke-Webrequest @Parameters
	}

	if (Test-Path -Path "$env:APPDATA\Mozilla\Firefox\Profiles\$ProfileName\chrome\image") {
		$Images = @(
			# about-logo-private-changed.png
			# https://github.com/lowl1f3/Firefox/blob/main/icons/about-logo-private-changed.png
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/about-logo-private-changed.png",

			# eye.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/eye.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/eye.svg",

			# files.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/files.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/files.svg",

			# files-light.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/files-light.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/files-light.svg",

			# firefox.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/firefox.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/firefox.svg",

			# firefox-light.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/firefox-light.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/firefox-light.svg",

			# firefox-private.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/firefox-private.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/firefox-private.svg",

			# firefox-private-light.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/firefox-private-light.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/firefox-private-light.svg",

			# firefoxx.png
			# https://github.com/lowl1f3/Firefox/blob/main/icons/firefoxx.png
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/firefoxx.png",

			# left-arrow.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/left-arrow.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/left-arrow.svg",

			# left-arrow-light.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/left-arrow-light.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/left-arrow-light.svg",

			# menu.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/menu.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/menu.svg",

			# menu-light.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/menu-light.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/menu-light.svg",

			# menu-private.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/menu-private.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/menu-private.svg",

			# menu-private-light.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/menu-private-light.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/menu-private-light.svg",

			# noise-512x512.png
			# https://github.com/lowl1f3/Firefox/blob/main/icons/noise-512x512.png
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/noise-512x512.png",

			# private.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/private.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/private.svg",

			# private-light.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/private-light.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/private-light.svg",

			# right-arrow.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/right-arrow.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/right-arrow.svg",

			# right-arrow-light.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/right-arrow-light.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/right-arrow-light.svg",

			# search.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/search.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/search.svg",

			# search-glass.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/search-glass.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/search-glass.svg",

			# search-light.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/search-light.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/search-light.svg",

			# spill.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/spill.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/spill.svg",

			# spill-main.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/spill-main.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/spill-main.svg",

			# stack.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/stack.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/stack.svg",

			# three-dots-vertical.svg
			# https://github.com/lowl1f3/Firefox/blob/main/icons/three-dots-vertical.svg
			"https://raw.githubusercontent.com/lowl1f3/Firefox/main/icons/three-dots-vertical.svg"
		)

		Write-Warning -Message "Downloading images..."

		# Loop
		foreach ($Image in $Images) {
			Write-Information -MessageData "" -InformationAction Continue
			Write-Verbose -Message $(Split-Path -Path $Image -Leaf) -Verbose

			if ($(Split-Path -Path $Image -Leaf)) {
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

Start-Process -FilePath "https://github.com/lowl1f3/Firefox#before-running"
