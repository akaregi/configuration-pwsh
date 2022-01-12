$configPath = $profile.Replace("\Microsoft.PowerShell_profile.ps1", "")
$path = $configPath + "/config/starship.toml"
$ENV:STARSHIP_CONFIG = $path

Invoke-Expression (&starship init powershell)