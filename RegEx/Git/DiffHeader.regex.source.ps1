$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Pattern '(?m)' -Description "Matches Header information from the output of git diff" |
Write-RegEx -Pattern 'diff' -StartAnchor LineStart  -Comment 'diff line start' |
    Write-Regex -CharacterClass Whitespace |
    Write-Regex '--git' |
    Write-Regex -CharacterClass Whitespace -Comment 'whitespace, then --git, then whitespace' |
    Write-RegEx -Name From -CharacterClass NonWhitespace -Repeat -Comment From |
    Write-Regex -CharacterClass Whitespace -Comment Whitespace |
    Write-RegEx -Name To -CharacterClass NonWhitespace -Repeat -Comment To |
    Write-RegEx -Name ExtendedHeader -Until (
        Write-RegEx -Pattern 'index\s{1}' -StartAnchor LineStart
    ) -Comment "Until 'index'"  <#  |
    Write-RegEx -Pattern 'index' |
    Write-RegEx -CharacterClass Whitespace -Comment 'Index Line Start' |
    Write-RegEx -Name FromHash -CharacterClass Word -Repeat -Comment FromHash |
    Write-RegEx -LiteralCharacter '.' -Min 2 -Max 2 -Comment DotDot |
    Write-RegEx -Name ToHash -CharacterClass Word -Repeat -Comment ToHash |
    Write-RegEx -CharacterClass Whitespace |
    Write-RegEx -Name Mode -CharacterClass Word -Repeat -Comment FileMode |
    Write-RegEx -Until (
        Write-RegEx '---' -StartAnchor LineStart
    ) -Comment UntilDashLine |
    Write-RegEx -LiteralCharacter '-' -Min 3 -Max 3 |
    Write-RegEx -CharacterClass Whitespace -Comment DashLineAndWhitespace | 
    Write-RegEx -Name FromUnified -CharacterClass NonWhitespace -Repeat -Comment FromUnified |
    Write-RegEx -CharacterClass Whitespace -Repeat| 
    Write-RegEx -LiteralCharacter '+' -Min 3 -Max 3 |
    Write-RegEx -CharacterClass Whitespace -Comment PlusLineAndWhitespace |
    Write-RegEx -Name ToUnified -CharacterClass NonWhitespace -Repeat -Comment ToUnified |
    Write-RegEx -CharacterClass Whitespace #> |
    Set-Content -Path (Join-Path $myRoot $myName)

