$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Description "Matches an IPv4 Address" |    
    Write-RegEx -CharacterClass Digit -Min 1 -Max 3 -Comment '1-3 digits' |
    Write-RegEx -LiteralCharacter . -Comment 'a dot' |
    Write-RegEx -CharacterClass Digit -Min 1 -Max 3 -Comment '1-3 digits' | 
    Write-RegEx -LiteralCharacter . -Comment 'a dot' |
    Write-RegEx -CharacterClass Digit -Min 1 -Max 3 -Comment '1-3 digits' | 
    Write-RegEx -LiteralCharacter . -Comment 'a dot' |
    Write-RegEx -CharacterClass Digit -Min 1 -Max 3 |    
    Set-Content -Path (Join-Path $myRoot $myName)



