$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches ANSI Hide (aka conceal) Start or End" |
    New-RegEx -CharacterClass Escape -Comment 'An Escape' |
    New-RegEx -LiteralCharacter '[' -Comment 'Followed by a bracket' |
    New-RegEx  -Atomic -Or -Pattern @(
        New-RegEx -Name "HideStart" -Pattern '8m' -Comment "8m starts hide"
        New-RegEx -Name "HideEnd" -Pattern '28m'  -Comment "28m stops hide"
    ) |    
    Set-Content -Path (Join-Path $myRoot $myName)
