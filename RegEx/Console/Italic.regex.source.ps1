$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches ANSI Italic Start or End" |
    New-RegEx -CharacterClass Escape -Comment 'An Escape' |
    New-RegEx -LiteralCharacter '[' -Comment 'Followed by a bracket' |
    New-RegEx  -Atomic -Or -Pattern @(
        New-RegEx -Name "ItalicStart" -Pattern '3m' -Comment "3m starts italic"
        New-RegEx -Name "ItalicEnd" -Pattern '23m'  -Comment '23m stops italic'
    ) |    
    Set-Content -Path (Join-Path $myRoot $myName)
