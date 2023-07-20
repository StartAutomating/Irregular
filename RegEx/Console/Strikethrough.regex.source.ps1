$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches ANSI Strikethrough (aka crossed out) Start or End" |
    New-RegEx -CharacterClass Escape -Comment 'An Escape' |
    New-RegEx -LiteralCharacter '[' -Comment 'Followed by a bracket' |
    New-RegEx  -Atomic -Or -Pattern @(
        New-RegEx -Name "StrikethroughStart" -Pattern '9m' -Comment "9m starts Strikethrough"
        New-RegEx -Name "StrikethroughEnd" -Pattern '29m'  -Comment "29m stops Strikethrough"
    ) |    
    Set-Content -Path (Join-Path $myRoot $myName)
