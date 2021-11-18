#requires -Module Irregular
$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Description "Matches Open SCAD Functions" |
    Write-RegEx -Modifier Multiline -Comment 'Set Multiline mode.  Then,' |
    Write-RegEx -Pattern '//[\s.]{0,}?$(?>\r\n|\n)' -Min 0 -Name Comments |
    Write-RegEx -Pattern function -StartAnchor LineStart -Comment "match the literal 'function'" |
    Write-RegEx -CharacterClass Whitespace -Repeat -Comment 'and the obligitory whitespace.' |
    Write-RegEx -CharacterClass Word -Repeat -Name Name -Comment 'Then match and extract the .Name' |
    Write-RegEx -CharacterClass Whitespace -Comment 'Then, there may be whitespace.' -min 0 |
    Write-RegEx -Pattern '(?<Parameters>?<BalancedParenthesis>)' -Description 'The .Parameters are within ()' |
    Write-RegEx -CharacterClass Whitespace -Comment 'Then, there may be whitespace.' -min 0 |
    Write-RegEx -LiteralCharacter '=' |
    Write-RegEx -CharacterClass Whitespace -Comment 'Then, there may be whitespace.' -min 0 |
    Write-RegEx -Until ';' | 
    Set-Content -Path (Join-Path $myRoot $myName)


