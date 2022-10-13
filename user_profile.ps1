# Prompt Imports
Import-Module Terminal-Icons
Import-Module posh-git
# Tem um problema com o antivirus do windows que enxerga o binário do FZF como uma ameaça e não permite acesso ao repositório ou instalando via choco ou scoop.
# Import-Module PSFzf

# Show weather
curl wttr.in/Lauro_de_Freitas?format="%l:+%c+%t+%m\n"
# Load Oh My Posh prompt (with custom theme) config file
$omp_config = Join-Path $env:USERPROFILE\.config\powershell "gugaguga.omp.json"
oh-my-posh init pwsh --config $omp_config | Invoke-Expression

# Import-Module oh-my-posh
# O Oh My Posh não suporta mais módulos do PowerShell. Para instalá-lo, terá que usar outra ferramenta.
# Clique no link abaixo para ver como migrar.
# https://ohmyposh.dev/docs/migrating

# PSReadLine
# Autosugestões do PSReadline
Set-PSReadlineOption -ShowToolTips
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineOption -HistorySearchCursorMovesToEnd

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
# Autocomplete, keybinds e histórico de comandos [ Comandos para usar no modo Emacs ]
# Set-PSReadLineKeyHandler -Chord 'Ctrl+RightArrow' -Function ForwardWord
# Set-PSReadLineKeyHandler -Chord 'Ctrl+LeftArrow' -Function BackwardWord
# Set-PSReadLineKeyHandler -Chord 'Ctrl+Shift+RightArrow' -Function SelectForwardWord
# Set-PSReadLineKeyHandler -Chord 'Ctrl+Shift+LeftArrow' -Function SelectBackwardWord
# Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
# Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Fzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Env
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

# Default browser
$browser = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"

# Alias
Set-Alias eth Get-NetAdapter
Set-Alias vim nvim
Set-Alias g git
Set-Alias ogh openGitHub
Set-Alias lg lazygit
Set-Alias ls lsd
Set-Alias ll lla
Set-Alias ln $env:USERPROFILE\scoop\apps\psutils\current\ln.ps1
Set-Alias find fd
Set-Alias sed 'C:\Program Files\Git\usr\bin\sed.exe'
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias grep 'C:\Program Files\Git\usr\bin\grep.exe'
# Set-Alias grep findstr
Set-Alias wget $env:USERPROFILE\scoop\apps\wget\current\wget.exe
Set-Alias ytscpt $env:USERPROFILE\scoop\shims\youtube-dl_script.ps1
Set-Alias pwd $env:USERPROFILE\scoop\apps\unxutils\current\usr\local\wbin\pwd.exe
Set-Alias mkdir $env:USERPROFILE\scoop\apps\unxutils\current\usr\local\wbin\mkdir.exe
Set-Alias touch $env:USERPROFILE\scoop\apps\unxutils\current\usr\local\wbin\touch.exe
Set-Alias msedge $browser
Set-Alias upd update
Set-Alias otf openThisFolder

# Aliases for lsd (LSDeluxe), inspired by colorls project
$lsd_config = Join-Path $env:USERPROFILE\.config\powershell "lsd-config.yaml"
function l { ls -Xl -v --config-file $lsd_config }
function la { ls -Xa -v --config-file $lsd_config }
function lla { ls -Xla -v --config-file $lsd_config }
function lt { ls -X -v --tree --config-file $lsd_config }

# Utilities
function update {
  Write-Output "Updating npm..."
  sudo npm-windows-upgrade --npm-version latest &&
  ncu -g
  $ncuUpdate = ncu -g | Where-Object { $_.Contains("ncu itself cannot upgrade global packages.") }
  if ($null -ne $ncuUpdate) {
    npm -g install npm-check-updates@latest
    $version = ncu -V
    Write-Output "npm check updates were updated successfully to version $version"
  }

  Write-Output "`nUpdating Python..."
  # run pip list and check if there is this warning: "WARNING: Ignoring invalid distribution -ip (c:\python310\lib\site-packages)"
  $list = pip list | Where-Object { $_.Contains("Ignoring invalid distribution -ip (c:\python310\lib\site-packages") }
  if ($null -ne $list) {
    # if there is a warning, then remove all invalid distributions 
    Write-Output "Removing invalid distributions..."
    sudo rm -r 'c:\python310\lib\site-packages\~*'
    Write-Output "Everything is shiny now!"
  }
  else {
    Write-Output "No invalid distributions found! 😁👍"
  }
  sudo python.exe -m pip install --upgrade pip
  Write-Output "`nUpdating Choco..."
  sudo choco upgrade all &&
  Write-Output "`nUpdating Scoop..."
  scoop update * && scoop cleanup * &&
  Write-Output "`nUpdating Winget..."
  winget upgrade --all && 
  Write-Output "`nUpdating PowerShell Modules..."
  Update-Module -Name Terminal-Icons -Force &&
  Update-Module -Name posh-git -Force &&
  # Update-Module -Name PSFzf -Force &&
  Update-Module -Name z -Force &&
  Update-Module -Name PSReadLine -Force
  refreshenv
}

# Function to search things on Google
function google_it_for_me ($search) {
  if ($null -eq $search) {
    Write-Output "Usage: google_it_for_me <search>"
  }
  else {
    Write-Output "Searching for '$search' on Google..."
    Start-Process "https://www.google.com/search?q=$search"
  }
}

function Install-Fonts {
  #   $SourceDir   = Join-Path $env:USERPROFILE "\.fonts"
  #   $Source   = Join-Path $env:USERPROFILE "\.fonts"
  #   $Destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
  #   $TempFolder  = "C:\Windows\Temp\Fonts"

  # # Create the source directory if it doesn't already exist
  #   New-Item -ItemType Directory -Force -Path $SourceDir

  #   New-Item $TempFolder -Type Directory -Force | Out-Null

  #   Get-ChildItem -Path $Source -Include '*.ttf','*.ttc','*.otf' -Recurse | ForEach {
  #       If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {

  #           $Font = "$TempFolder\$($_.Name)"
  #           
  #           # Copy font to local temporary folder
  #           Copy-Item $($_.FullName) -Destination $TempFolder
  #           
  #           # Install font
  #           $Destination.CopyHere($Font,0x14)

  #           # Delete temporary copy of font
  #           Remove-Item $Font -Force -SilentlyContinue
  #       }
  #   }

  Write-Output "Install fonts"
  $fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
  foreach ($file in Get-ChildItem *.ttf) {
    $fileName = $file.Name
    if (-not(Test-Path -Path "C:\Windows\fonts\$fileName" )) {
      Write-Output $fileName
      Get-ChildItem $file | ForEach-Object { $fonts.CopyHere($_.fullname) }
    }
  }
  sudo cp *.ttf c:\windows\fonts\
}

# Function to create a new File
# function touch {
#   $file = $args[0]
#   if ($file -eq $null) {
#     Write-Output "Usage: touch <file>"
#   } else {
#     New-Item -ItemType File -Force -Path $file
#   }
# }

function weather { curl wttr.in/Lauro_de_Freitas?lang=pt }

function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
  Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function openGitHub {
  $url = "https://github.com/siqueira-gustavo"
  if ($url -eq $null) {
    return
  }
  # Open URL in default browser
  if ($browser) {
    Start-Process -FilePath $browser -ArgumentList $url
  }
  else {
    Start-Process -FilePath "chrome" -ArgumentList $url
  }
}

function pwsh-folder { cd $env:USERPROFILE\.config\powershell }
function pwsh-code { code $env:USERPROFILE\.config\powershell\user_profile.ps1 }
function pwsh-vim { vim $env:USERPROFILE\.config\powershell\user_profile.ps1 }
function nvim-config { vim $env:USERPROFILE\AppData\Local\nvim }
function nvim-folder { cd $env:USERPROFILE\AppData\Local\nvim }
function unxutil { cd $env:USERPROFILE\scoop\apps\unxutils\current\usr\local\wbin\ }
function docs { cd 'D:\Users\guss_\Documents\' }
function codar { cd 'D:\Users\guss_\Documents\CODE' }
function SARP { cd 'D:\Users\guss_\Documents\# SARP' }
function guga { cd 'D:\Users\guss_\Documents\# PESSOAIS' }
function jw { cd 'D:\Users\guss_\Documents\# PESSOAIS\Teocráticos' }
function CVA { code 'D:\Users\guss_\Documents\CODE\PESSOAIS\Projects\Relatórios SR\CVA' }
function vCVA { vim 'D:\Users\guss_\Documents\CODE\PESSOAIS\Projects\Relatórios SR\CVA' }
function rast-config { code 'D:\Users\guss_\Documents\CODE\PESSOAIS\Projects\correios_cli' }
function openThisFolder { explorer . }

# git aliases
function ghi { git init }
function ga { git add . }
function gra { git restore --staged * }
function gr ($file) {
  if ($null -eq $file) {
    Write-Output "Usage: gr <file name>"
  }
  else {
    git restore --staged "$file"
  }
}
function gs { git status }
function gp { git pull }
function gpsh { git push }
function gpom ($branch) {
  if ($null -eq $branch) {
    Write-Output "Usage: gpom <branch>"
  }
  else {
    git push -u origin $branch
  }
}
function gpo { git push origin }
function gpl { git pull origin }
function gd { git diff }
function glog { git log }
function gco ($commit) { 
  if ($null -eq $commit) {
    Write-Output "Usage: gco <commit>"
  }
  else {
    git commit -m "$commit"
  }
}
function gcout ($file) { 
  if ($null -eq $file) {
    Write-Output "Usage: gcout <file name>"
  }
  else {
    git checkout "$file"
  }
}
function gcl ($url) { 
  if ($null -eq $url) {
    Write-Output "Usage: gcl <url>"
  }
  else {
    git clone "$url"
  }
}
function gb { git branch }
function gbm ($branch) {
  if ($null -eq $branch) {
    Write-Output "Usage: gbm <branch>"
  }
  else {
    git branch -m "$branch"
  }
}
function gbl { git branch -a | grep -v '\*' | sed 's/^..//' } # Which branch I am
function grao ($repo_name) {
  if ($null -eq $repo_name) {
    Write-Output "Usage: grao <repo_name>"
  }
  else {
    git remote add origin git@github.com:siqueira-gustavo/$repo_name.git
  }
}
function g1st {
  Write-Host "Let's create our first commit..."
  $commit = Read-Host -Prompt "Enter your commit message"
  $branch = Read-Host -Prompt "Enter which branch (main, master...?)"
  $repo_name = Read-Host -Prompt "Enter the name of the repository"
  ghi             # git init
  ga              # git add .
  gco $commit     # git commit "$commit"
  gbm $branch     # git branch -m "$branch"
  grao $repo_name # git remote add origin git@github.com:siqueira-gustavo/$repo_name.git
  gpom $branch    # git push -u origin $branch
}

# Minha lista de comandos
function Listar-Atalhos {
  Write-Output "----------------------------------------"
  Write-Output "Atalhos Customizados"
  Write-Output "----------------------------------------"
  Write-Output "ll          - Listar os arquivos do diretório atual"
  Write-Output "lt          - Listar os arquivos do diretório atual em árvore"
  Write-Output "eth         - Lista os endereços de rede"
  Write-Output "vim         - Abre o editor nvim"
  Write-Output "duf         - Disk Usage/Free Utility (Linux, BSD, macOS & Windows)"
  Write-Output "img2pdf     - Losslessly convert raster images to PDF (Usage: img2pdf <input_file.jpg, .png, etc.> -o <output_file.pdf>)"
  Write-Output "ntop        - htop similar to Windows Task Manager"
  Write-Output "btm         - htop similar to Windows Task Manager"
  Write-Output "lf          - File Browser (Windows), similar to Ranger (Linux, BSD, macOS)"
  Write-Output "spt         - Spotify TUI (Linux, BSD, macOS & Windows) - A Spotify client for the terminal written in Rust."
  Write-Output "cash        - Faz conversão de moedas"
  Write-Output "curl        - Faz requisições HTTP"
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
  Write-Output "pwsh-vim    - Abre as configurações do powershell no VIM"
  Write-Output "pwsh-code   - Abre as configurações do powershell no VS Code"
  Write-Output "codar       - Abre a pasta ﱮ \Code"
  Write-Output "SARP        - Abre a pasta ﱮ \# SARP"
  Write-Output "guga        - Abre a pasta ﱮ \# PESSOAIS"
  Write-Output "rast-config - Abre a pasta ﱮ \# PESSOAIS\Projects\correios_cli"
  Write-Output "CVA         - Abre o projeto CVA na pasta ﱮ \CODE\Projects\Relatórios SR\CVA no VS Code"
  Write-Output "vCVA        - Abre o projeto CVA na pasta ﱮ \CODE\Projects\Relatórios SR\CVA no VIM"
  Write-Output "abrir       - Abre o diretório atual"
  Write-Output "----------------------------------------"
  Write-Output "Atalhos do Git"
  Write-Output "----------------------------------------"
  Write-Output "openGitHub  - Abre meu perfil no GitHub"
  Write-Output "ogh         - Alias para openGitHub"
  Write-Output "lg          - alias para lazygit"
  Write-Output "g           - git"
  Write-Output "gi          - git init"
  Write-Output "ga          - git add ."
  Write-Output "gr          - git restore --staged *"
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


# Set-PSReadLineKeyHandler -Key '"', "'" `
#   -BriefDescription SmartInsertQuote `
#   -LongDescription "Insert paired quotes if not already on a quote" `
#   -ScriptBlock {
#   param($key, $arg)
#
#   $quote = $key.KeyChar
#
#   $selectionStart = $null
#   $selectionLength = $null
#   [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)
#
#   $line = $null
#   $cursor = $null
#   [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
#
#   # If text is selected, just quote it without any smarts
#   if ($selectionStart -ne -1) {
#     [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $quote + $line.SubString($selectionStart, $selectionLength) + $quote)
#     [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
#     return
#   }
#
#   $ast = $null
#   $tokens = $null
#   $parseErrors = $null
#   [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$parseErrors, [ref]$null)
#
#   function FindToken {
#     param($tokens, $cursor)
#
#     foreach ($token in $tokens) {
#       if ($cursor -lt $token.Extent.StartOffset) { continue }
#       if ($cursor -lt $token.Extent.EndOffset) {
#         $result = $token
#         $token = $token -as [StringExpandableToken]
#         if ($token) {
#           $nested = FindToken $token.NestedTokens $cursor
#           if ($nested) { $result = $nested }
#         }
#
#         return $result
#       }
#     }
#     return $null
#   }
#
#   $token = FindToken $tokens $cursor
#
#   # If we're on or inside a **quoted** string token (so not generic), we need to be smarter
#   if ($token -is [StringToken] -and $token.Kind -ne [TokenKind]::Generic) {
#     # If we're at the start of the string, assume we're inserting a new string
#     if ($token.Extent.StartOffset -eq $cursor) {
#       [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$quote$quote ")
#       [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
#       return
#     }
#
#     # If we're at the end of the string, move over the closing quote if present.
#     if ($token.Extent.EndOffset -eq ($cursor + 1) -and $line[$cursor] -eq $quote) {
#       [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
#       return
#     }
#   }
#
#   if ($null -eq $token -or
#     $token.Kind -eq [TokenKind]::RParen -or $token.Kind -eq [TokenKind]::RCurly -or $token.Kind -eq [TokenKind]::RBracket) {
#     if ($line[0..$cursor].Where{ $_ -eq $quote }.Count % 2 -eq 1) {
#       # Odd number of quotes before the cursor, insert a single quote
#       [Microsoft.PowerShell.PSConsoleReadLine]::Insert($quote)
#     }
#     else {
#       # Insert matching quotes, move cursor to be in between the quotes
#       [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$quote$quote")
#       [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
#     }
#     return
#   }
#
#   # If cursor is at the start of a token, enclose it in quotes.
#   if ($token.Extent.StartOffset -eq $cursor) {
#     if ($token.Kind -eq [TokenKind]::Generic -or $token.Kind -eq [TokenKind]::Identifier -or 
#       $token.Kind -eq [TokenKind]::Variable -or $token.TokenFlags.hasFlag([TokenFlags]::Keyword)) {
#       $end = $token.Extent.EndOffset
#       $len = $end - $cursor
#       [Microsoft.PowerShell.PSConsoleReadLine]::Replace($cursor, $len, $quote + $line.SubString($cursor, $len) + $quote)
#       [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($end + 2)
#       return
#     }
#   }
#
#   # We failed to be smart, so just insert a single quote
#   [Microsoft.PowerShell.PSConsoleReadLine]::Insert($quote)
# }
#
# Set-PSReadLineKeyHandler -Key '(', '{', '[' `
#   -BriefDescription InsertPairedBraces `
#   -LongDescription "Insert matching braces" `
#   -ScriptBlock {
#   param($key, $arg)
#
#   $closeChar = switch ($key.KeyChar) {
#     <#case#> '(' { [char]')'; break }
#     <#case#> '{' { [char]'}'; break }
#     <#case#> '[' { [char]']'; break }
#   }
#
#   $selectionStart = $null
#   $selectionLength = $null
#   [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)
#
#   $line = $null
#   $cursor = $null
#   [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
#     
#   if ($selectionStart -ne -1) {
#     # Text is selected, wrap it in brackets
#     [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $key.KeyChar + $line.SubString($selectionStart, $selectionLength) + $closeChar)
#     [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
#   }
#   else {
#     # No text is selected, insert a pair
#     [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)$closeChar")
#     [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
#   }
# }
#
# Set-PSReadLineKeyHandler -Key ')', ']', '}' `
#   -BriefDescription SmartCloseBraces `
#   -LongDescription "Insert closing brace or skip" `
#   -ScriptBlock {
#   param($key, $arg)
#
#   $line = $null
#   $cursor = $null
#   [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
#
#   if ($line[$cursor] -eq $key.KeyChar) {
#     [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
#   }
#   else {
#     [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)")
#   }
# }
