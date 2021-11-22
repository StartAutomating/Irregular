$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description @'
Matches FFMpeg configuration
'@  -StartAnchor LineStart -Pattern "\s{0,}configuration:" -Comment "Configuration: is followed by any number of flags" |
    Write-RegEx -NoCapture -Min 0 -Pattern (
        Write-RegEx -CharacterClass Whitespace -Repeat |
            Write-RegEx -LiteralCharacter '-' |
            Write-RegEx -LiteralCharacter '-' |
            Write-RegEx -CharacterClass NonWhitespace -Repeat -Name Flag -Comment "A flag is two dashes, followed by any number of non-whitespace characters"
    ) |    
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru

