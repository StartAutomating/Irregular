$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches an ANSI Bold (aka bright) Start or End" |
    New-RegEx -CharacterClass Escape -Comment 'An Escape' |
    New-RegEx -LiteralCharacter '[' -Comment 'Followed by a bracket' |
    New-RegEx  -Atomic -Or -Pattern @(
        New-RegEx -Name "BoldStart" -Pattern '1m' -Comment "1m starts bold"
        New-RegEx -Name "BoldEnd" -Pattern '22m'  -Comment '22m stops bold'
    ) |    
    Set-Content -Path (Join-Path $myRoot $myName)
