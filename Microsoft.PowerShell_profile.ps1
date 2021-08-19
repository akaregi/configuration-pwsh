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

# uutils
@"
  arch, base32, base64, basename, cat, cksum, comm, cp, cut, date, df, dircolors, dirname,
  echo, env, expand, expr, factor, false, fmt, fold, hashsum, head, hostname, join, link, ln,
  ls, md5sum, mkdir, mktemp, more, mv, nl, nproc, od, paste, printenv, printf, ptx, pwd,
  readlink, realpath, relpath, rm, rmdir, seq, sha1sum, sha224sum, sha256sum, sha3-224sum,
  sha3-256sum, sha3-384sum, sha3-512sum, sha384sum, sha3sum, sha512sum, shake128sum,
  shake256sum, shred, shuf, sleep, sort, split, sum, sync, tac, tail, tee, test, touch, tr,
  true, truncate, tsort, unexpand, uniq, wc, whoami, yes
"@ -split ',' |
ForEach-Object { $_.trim() } |
Where-Object { ! @('tee', 'sort', 'sleep').Contains($_) } |
ForEach-Object {
  $cmd = $_
  if (Test-Path Alias:$cmd) { Remove-Item -Path Alias:$cmd }
  $fn = '$input | uutils ' + $cmd + ' $args'
  Invoke-Expression "function global:$cmd { $fn }" 
}