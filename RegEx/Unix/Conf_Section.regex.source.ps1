$myFile = $MyInvocation.MyCommand.ScriptBlock.File
$myName = ($myFile | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $myFile | Split-Path

Write-RegEx -Pattern '(?m)' -Description "Matches Sections in a .conf file." |
    Write-RegEx -LiteralCharacter '[' |
    Write-RegEx -Name SectionName -Until ']' |
    Write-RegEx -Name SectionLines -Until '^\[' |
    Set-Content -Path (Join-Path $myRoot $myName)


