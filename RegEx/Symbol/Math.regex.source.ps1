$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches a Math Symbol" |
    New-RegEx -CharacterClass SymbolCurrency |
    Set-Content -Path (Join-Path $myRoot $myName)



