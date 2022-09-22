$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches ANSI Invert Start or End" |
    New-RegEx -CharacterClass Escape -Comment 'An Escape' |
    New-RegEx -LiteralCharacter '[' -Comment 'Followed by a bracket' |
    New-RegEx  -Atomic -Or -Pattern @(
        New-RegEx -Name "InvertStart" -Pattern '7m' -Comment "7m starts invert"
        New-RegEx -Name "InvertEnd" -Pattern '27m'  -Comment "27m stops invert"
    ) |    
    Set-Content -Path (Join-Path $myRoot $myName)
