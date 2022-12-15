$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches methods in most languages" |
    New-RegEx -After (
        New-RegEx -CharacterClass Punctuation, Whitespace, Tab
    ) -Comment "Methods start after punctuation or whitespace" |    
    New-RegEx -CharacterClass Word -LiteralCharacter _ -Repeat -Name MethodName -Comment "Method names can be any word character or undererscore" |
    New-RegEx -Description "A Generic Balancing Expression" -Name MethodParameters -Pattern '?<GenericBalancingExpression>' |
    Set-Content -Path (Join-Path $myRoot $myName)
