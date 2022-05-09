# Prompt Imports
Import-Module Terminal-Icons
Import-Module posh-git
# Import-Module PSFzf

# Import-Module oh-my-posh
# O Oh My Posh não suporta mais módulos do PowerShell. Para instalá-lo, terá que usar outra ferramenta.
# Clique no link abaixo para ver como migrar.
# https://ohmyposh.dev/docs/migrating

# Show weather
curl wttr.in/Lauro_de_Freitas?format="%l:+%c+%t+%m\n"
# Load Oh My Posh prompt (with custom theme) config file
$omp_config = Join-Path $env:USERPROFILE\.config\powershell "gugaguga.omp.json"
oh-my-posh init pwsh --config $omp_config | Invoke-Expression

# PSReadLine
# Autosugestões do PSReadline
Set-PSReadlineOption -ShowToolTips
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineOption -HistorySearchCursorMovesToEnd

# Autocomplete, keybinds e histórico de comandos
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Chord 'Ctrl+RightArrow' -Function ForwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+LeftArrow' -Function BackwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+Shift+RightArrow' -Function SelectForwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+Shift+LeftArrow' -Function SelectBackwardWord
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Fzf
# Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Env
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

# Alias
Set-Alias eth Get-NetAdapter
Set-Alias vim nvim
Set-Alias ls lsd
Set-Alias ll lla
Set-Alias g git
Set-Alias grep findstr
Set-Alias find fd
Set-Alias sed 'C:\Program Files\Git\usr\bin\sed.exe'
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias ytscpt 'C:\Users\guss_\scoop\shims\youtube-dl_script.ps1'

# Aliases for lsd (LSDeluxe), inspired by colorls project
$lsd_config = Join-Path $env:USERPROFILE\.config\powershell "lsd-config.yaml"
function l { ls -Xl --config-file $lsd_config }
function la { ls -Xa --config-file $lsd_config }
function lla { ls -Xla --config-file $lsd_config }
function lt { ls -X --tree --config-file $lsd_config }

# Utilities
function update {
  Write-Output "Updating Choco..."
  sudo choco upgrade all &&
  Write-Output "`nUpdating Scoop..."
  scoop update * && 
  Write-Output "`nUpdating Winget..."
  winget upgrade --all && 
  Write-Output "`nUpdating PowerShell Modules..."
  Update-Module -Name Terminal-Icons -Force &&
  Update-Module -Name PSReadLine -Force &&
  Update-Module -Name posh-git -Force &&
  # Update-Module -Name PSFzf -Force &&
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
  Write-Output "ll          - Listar arquivos"
  Write-Output "lt          - Listar arquivos em árvore"
  Write-Output "eth         - Lista os endereços de rede"
  Write-Output "vim         - Abre o editor nvim"
  Write-Output "duf         - Disk Usage/Free Utility (Linux, BSD, macOS & Windows)"
  Write-Output "btm         - htop similar to Windows Task Manager"
  Write-Output "broot       - File Browser (Windows), similar to Ranger (Linux, BSD, macOS)"
  Write-Output "spt         - Spotify TUI (Linux, BSD, macOS & Windows) - A Spotify client for the terminal written in Rust."
  Write-Output "cash        - Faz conversão de moedas"
  Write-Output "curl        - Faz requisições HTTP"
  Write-Output "ll          - Lista os arquivos do diretório atual"
  Write-Output "grep        - Busca por palavras no diretório atual"
  Write-Output "sed         - Substitui palavras no diretório atual"
  Write-Output "tig         - Abre o tig"
  Write-Output "less        - Abre o less"
  Write-Output "ytscpt      - Abre o Youtube-Script do youtube-dl"
  Write-Output "update      - Atualiza todos os pacotes do sistema (chocolatey, scoop, winget, Update-Module)"
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