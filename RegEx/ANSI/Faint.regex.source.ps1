$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches an ANSI Faint (aka dim) Start or End" |
    New-RegEx -CharacterClass Escape -Comment 'An Escape' |
    New-RegEx -LiteralCharacter '[' -Comment 'Followed by a bracket' |
    New-RegEx  -Atomic -Or -Pattern @(
        New-RegEx -Name "FaintStart" -Pattern '2m' -Comment "2m starts faint"
        New-RegEx -Name "FaintEnd" -Pattern '22m'  -Comment '22m stops faint'
    ) |    
    Set-Content -Path (Join-Path $myRoot $myName)
