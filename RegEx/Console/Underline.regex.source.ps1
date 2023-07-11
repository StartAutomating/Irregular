$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches ANSI Underline/DoubleUnderline Start or Underline End" |
    New-RegEx -CharacterClass Escape -Comment 'An Escape' |
    New-RegEx -LiteralCharacter '[' -Comment 'Followed by a bracket' |
    New-RegEx  -Atomic -Or -Pattern @(
        New-RegEx -Name "UnderlineStart" -Pattern '4m' -Comment "4m starts underline"
        New-RegEx -Name "DoubleUnderlineStart" -Pattern '21m' -Comment '21m start a double underline'        
        New-RegEx -Name "UnderlineEnd" -Pattern '24m'  -Comment "24m stops underline"
    ) |    
    Set-Content -Path (Join-Path $myRoot $myName)
