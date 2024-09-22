$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-Regex -Description "Matches a JavaScript Class" |
    New-RegEx -Pattern 'class' -Comment 'Class Keyword' |
    New-RegEx -Pattern '\s+' -Comment 'Whitespace' |
    New-RegEx -Name ClassName -CharacterClass NonWhitespace -Min 1 -Comment 'Class Name' |
    New-RegEx -Pattern '\s{0,}' -Comment 'Optional whitespace' |
    New-RegEx -Name ClassModifier (
        New-Regex -Not -LiteralCharacter '{' -Min 0
    ) |
    New-RegEx -Pattern '\s{0,}' -Comment 'Optional whitespace' |
    New-Regex -Name ClassBody -Comment "The class body" -Pattern '?<BalancedCurlyBracket>' |
    Set-Content -Path (Join-Path $myRoot $myName)
