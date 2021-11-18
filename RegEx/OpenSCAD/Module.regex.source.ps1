#requires -Module Irregular
$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Description "Matches Open SCAD Modules" |
    Write-RegEx -Modifier Multiline -Comment 'Set Multiline mode.  Then,' |
    Write-RegEx -Pattern module -StartAnchor LineStart -Comment "match the literal 'module'" |
    Write-RegEx -CharacterClass Whitespace -Repeat -Comment 'and the obligitory whitespace.' |
    Write-RegEx -CharacterClass Word -Repeat -Name ModuleName -Comment 'Then match and extract the <ModuleName>.' |
    Write-RegEx -CharacterClass Whitespace -Comment 'Then, there may be whitespace.' -min 0 |
    Write-RegEx -Pattern '(?<Parameters>?<BalancedParenthesis>)' -Description 'The Module <ModuleParameters> are within ()' |
    Write-RegEx -CharacterClass Whitespace -Comment 'Then, there may be whitespace.' -min 0 |
    Write-RegEx -Pattern '(?<Definition>?<BalancedCurlyBracket>)' -Description 'The Module <ModuleDefinition> is Within {}' | 
    Set-Content -Path (Join-Path $myRoot $myName)


