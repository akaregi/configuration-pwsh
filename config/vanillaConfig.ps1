# PROMPT
function prompt {
  # Represents the user
  $user = [Security.Principal.WindowsIdentity]::GetCurrent().Name.split("\")[1]

  # Represents the current time
  $date = Get-Date -Format "HH:mm:ss"

  # Represents the current path
  $path = Split-Path -Path $pwd -Leaf

  # Represents the current permission group
  # if you're a normal user, shows $
  # if you are the root, shows #
  $elevation = $(
    $IsAdmin = (
      New-Object Security.Principal.WindowsPrincipal (
        [Security.Principal.WindowsIdentity]::GetCurrent()
      )
    ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

    if ($IsAdmin) {
      "#"
    }
    else {
      "$"
    }
  )

  # 1st line
  Write-Host "┌ "           -ForegroundColor white  -NoNewline
  Write-Host "$($user) "    -ForegroundColor blue   -NoNewline
  Write-Host "./$($path)/ " -ForegroundColor green  -NoNewline
  Write-Host ""

  # 2nd line
  Write-Host "└ "           -ForegroundColor white  -NoNewline
  Write-Host "$($date) "    -ForegroundColor yellow -NoNewline
  Write-Host $elevation                             -NoNewline

  return " "
}