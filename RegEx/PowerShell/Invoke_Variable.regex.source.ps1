$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description @'
Matches any time a variable is invoked (with the . or & operator)
'@ -NotAfter '[\w\)`]' -Comment 'If the text before the invoke is a word, closing paranthesis, or backtick, do not match' | 
    Write-RegEx -LiteralCharacter '.&' -Name CallOperator -Comment "Match the <CallOperator> (either a . or a &)"  |
    Write-RegEx -CharacterClass Whitespace -Min 0 -Comment "Followed by Optional Whitespace" |
    Write-RegEx -LiteralCharacter '$' -Comment "Followed by a Dollar Sign" |
    Write-RegEx -Pattern @(
        Write-RegEx -CharacterClass Word -Repeat -Name Variable -Comment 'Followed by a <Variable> (any number of repeated word characters)'
        Write-RegEx -Between '{','}' -Name Variable -EscapeSequence '`' -Description 'Or a <Variable> enclosed in curly brackets' -Comment 'using backtick as an escape'
    ) -Or |
    Set-Content -Path (Join-Path $myRoot $myName)
