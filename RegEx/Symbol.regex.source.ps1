$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches a Symbol" |
    New-RegEx -CharacterClass Symbol |
    Set-Content -Path (Join-Path $myRoot $myName)



