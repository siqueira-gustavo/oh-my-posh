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
Set-Alias ytscpt 'C:\Users\guss_\scoop\shims\youtube-dl_script.ps1'

# Utilities
function update { 
  sudo choco upgrade all &&
  scoop update * && 
  winget upgrade --all && 
  Update-Module -Name Terminal-Icons -Force &&
  Update-Module -Name oh-my-posh -Force &&
  Update-Module -Name PSReadLine -Force &&
  Update-Module -Name PSFzf -Force &&
  Update-Module -Name z -Force
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

function pwsh-config { cd 'C:\Users\guss_\.config\powershell' }
function pwsh-code { code 'C:\Users\guss_\.config\powershell' }
function codar { cd 'D:\Users\guss_\Documents\CODE' }
function SARP { cd 'D:\Users\guss_\Documents\# SARP' }
function guga { cd 'D:\Users\guss_\Documents\# PESSOAIS' }
function CVA { code 'D:\Users\guss_\Documents\CODE\PESSOAIS\Projects\Relatórios SR\CVA' }
function rast-config { code 'D:\Users\guss_\Documents\CODE\PESSOAIS\Projects\correios_cli' }
function abrir { explorer . }

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
function gco { git commit -m "$1" }
function gca { git commit -am "$1" }
function gcout { git checkout "$1" }
function gb { git branch }
function gba { git branch -a }
function gbD { git branch -D "$1" }
function gbR { git branch -m "$1" }
function gbM { git branch -m "$1" "$2" }
function gbA { git branch -a -D "$1" }
function gbl { git branch -a | grep -v '\*' | sed 's/^..//' }
function gcl { git clone "$1" }

# Minha lista de comandos
function Listar-Atalhos {
  Write-Output "----------------------------------------"
  Write-Output "Atalhos Customizados"
  Write-Output "----------------------------------------"
  Write-Output "eth         - Lista os endereços de rede"
  Write-Output "vim         - Abre o editor vim"
  Write-Output "ll          - Lista os arquivos do diretório atual"
  Write-Output "grep        - Busca por palavras no diretório atual"
  Write-Output "sed         - Substitui palavras no diretório atual"
  Write-Output "tig         - Abre o tig"
  Write-Output "less        - Abre o less"
  Write-Output "ytscpt      - Abre o Youtube-Script do youtube-dl"
  Write-Output "update      - Atualiza o sistema (chocolatey, scoop, winget, Update-Module)"
  Write-Output "cls         - Limpa a tela"
  Write-Output "exit        - Fecha o shell"
  Write-Output "weather     - Mostra a previsão do tempo"
  Write-Output "which       - Mostra o caminho do arquivo"
  Write-Output "pwsh-config - Abre a pasta ﱮ \.config\powershell"
  Write-Output "pwsh-code   - Abre a pasta ﱮ \.config\powershell"
  Write-Output "codar       - Abre a pasta ﱮ \Code"
  Write-Output "SARP        - Abre a pasta ﱮ \# SARP"
  Write-Output "guga        - Abre a pasta ﱮ \# PESSOAIS"
  Write-Output "CVA         - Abre a pasta ﱮ \# PESSOAIS\Projects\Relatórios SR\CVA"
  Write-Output "rast-config - Abre a pasta ﱮ \# PESSOAIS\Projects\correios_cli"
  Write-Output "abrir       - Abre o diretório atual"
    Write-Output "----------------------------------------"
  Write-Output "Atalhos do Git"
  Write-Output "----------------------------------------"
  Write-Output "openGitHub  - Abre meu perfil no GitHub"
  Write-Output "g           - git"
  Write-Output "gi          - git init"
  Write-Output "ga          - git add ."
  Write-Output "gs          - git status"
  Write-Output "gp          - git pull"
  Write-Output "gpsh        - git push"
  Write-Output "gpom        - git push origin main"
  Write-Output "gpo         - git push origin"
  Write-Output "gpl         - git pull origin"
  Write-Output "gd          - git diff"
  Write-Output "gco         - git commit -m 'message' (escreva a mensagem em uma váriavel $ 1)"
  Write-Output "gca         - git commit -am 'message' (escreva a mensagem em uma váriavel $ 1)"
  Write-Output "gcout       - git checkout"
  Write-Output "gb          - git branch"
  Write-Output "gba         - git branch -a"
  Write-Output "gb          - git branch"
  Write-Output "gbD         - git branch -D '$ 1' (escreva o nome da branch em uma váriavel $ 1)"
  Write-Output "gbR         - git branch -m '$ 1' (escreva o nome da branch em uma váriavel $ 1)"
  Write-Output "gbM         - git branch -m '$ 1' '$ 2' (escreva o nome da branch em uma váriavel $ 1 e o nome da branch em uma váriavel $ 2)"
  Write-Output "gbA         - git branch -a -D '$ 1' (escreva o nome da branch em uma váriavel $ 1)"
  Write-Output "gbl         - git branch -a | grep -v '\*' | sed 's/^..//'"
  Write-Output "gcl         - git clone '$ 1' (escreva o caminho do repositório em uma váriavel $ 1)"
}