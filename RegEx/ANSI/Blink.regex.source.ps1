$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches ANSI Blink Start or End" |
    New-RegEx -CharacterClass Escape -Comment 'An Escape' |
    New-RegEx -LiteralCharacter '[' -Comment 'Followed by a bracket' |
    New-RegEx  -Atomic -Or -Pattern @(
        New-RegEx -Name "BlinkStart" -Atomic -Or @(
            New-RegEx -Name "BlinkSlow" -Pattern '5m'  -Comment '5m starts a slow blink'
            New-RegEx -Name "BlinkFast" -Pattern '6m'  -Comment '6m starts a slow blink'
        ) 
        New-RegEx -Name "BlinkEnd" -Pattern '25m'  -Comment "25m stops blinks"
    ) |
    Set-Content -Path (Join-Path $myRoot $myName)
