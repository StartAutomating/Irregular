$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description @'
Matches FFMpeg metadata
'@  -StartAnchor LineStart -Pattern "\s{4,}" -Comment "Metadata can occur on any line, as long as there are at least four spaces at the start" |
    Write-RegEx -Name Key -Not -CharacterClass Whitespace -LiteralCharacter ':' -Repeat -Optional -Comment "It may contain a key" |
    Write-RegEx -CharacterClass Whitespace -Min 0  -Comment "Followed by optional whitespace and a colon" |
    Write-RegEx -LiteralCharacter ':' |
    Write-RegEx -CharacterClass Whitespace -Min 1 -Comment "Ignore leading whitespace" |
    Write-RegEx -Until (Write-RegEx -CharacterClass NewLine, CarriageReturn) -Name Value -Comment "Anything until the end of the line is the value" |
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru

