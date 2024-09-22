$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-Regex -Description "JavaScript Method" |
    New-RegEx -After '[\r\n\;]' -Comment 'After a newline or semicolon' |
    New-RegEx -Pattern '\s{0,}' -Comment 'Optional whitespace' |
    New-RegEx -Name MethodName -Pattern '[^/\(\)\{\}]' -Repeat -Comment 'Method Name' |
    New-RegEx -Pattern '\s{0,}' -Comment 'Optional whitespace' |
    New-RegEx -Name MemberParameters -Pattern '?<BalancedParenthesis>' -Comment 'Method Parameters' |
    New-RegEx -Pattern '\s{0,}' -Comment 'Optional whitespace' |
    New-RegEx -Name MemberBody -Pattern '?<BalancedCurlyBracket>' -Comment 'Method Body' |
    Set-Content -Path (Join-Path $myRoot $myName)