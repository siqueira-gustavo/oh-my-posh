# Prompt
Import-Module posh-git
Import-Module oh-my-posh

# Load prompt config
$omp_config = Join-Path $PSScriptRoot ".\gugaguga.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

# Set-PoshPrompt -Theme clean-detailed
# Set-PoshPrompt -Theme space

Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Env
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

# Alias
Set-Alias eth Get-NetAdapter
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias sed 'C:\Program Files\Git\usr\bin\sed.exe'
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

# Utilities
function update { 
  sudo choco upgrade all &&
  scoop update * && 
  winget upgrade --all && 
  Update-Module -Name oh-my-posh -Scope CurrentUser
}

function weather { curl wttr.in/Lauro_de_Freitas?lang=pt }

function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function openGitHub {
  $url = "https://github.com/siqueira-gustavo"
  $browser = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
  if ($url -eq $null) {
    return
  }
  # Open URL in default browser
  if ($browser) {
    Start-Process -FilePath $browser -ArgumentList $url
  } else {
    Start-Process -FilePath "chrome" -ArgumentList $url
  }
}

function codar { cd 'D:\Users\guss_\Documents\CODE' }
function pwsh-config { cd 'C:\Users\guss_\.config\powershell' }
function pwsh-code { code 'C:\Users\guss_\.config\powershell' }

# git aliases
function gi { git init }
function ga { git add . }
function gs { git status }
function gp { git pull }
function gpsh { git push }
function gpom { git push -u origin main }
function gpo { git push origin }
function gpl { git pull origin }
function gd { git diff }
function gic { git commit -m "$1" }
function gca { git commit -am "$1" }
function gco { git checkout "$1" }
function gb { git branch }
function gba { git branch -a }
function gbD { git branch -D "$1" }
function gbR { git branch -m "$1" }
function gbM { git branch -m "$1" "$2" }
function gbA { git branch -a -D "$1" }
function gbl { git branch -a | grep -v '\*' | sed 's/^..//' }