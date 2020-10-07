$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Pattern '(?m)' |
Write-RegEx -Pattern 'diff' -StartAnchor LineStart  |
    Write-Regex -CharacterClass Whitespace |
    Write-Regex '--git' |
    Write-Regex -CharacterClass Whitespace |
    Write-RegEx -Name From -CharacterClass NonWhitespace -Repeat |
    Write-Regex -CharacterClass Whitespace |
    Write-RegEx -Name To -CharacterClass NonWhitespace -Repeat |
    Write-RegEx -Name ExtendedHeader -Until (
        Write-RegEx 'index' -StartAnchor LineStart
    ) |
    Write-RegEx 'index' -StartAnchor LineStart |
    Write-RegEx -CharacterClass Whitespace |
    Write-RegEx -Name FromHash -CharacterClass Word -Repeat |
    Write-RegEx -LiteralCharacter '.' -Min 2 -Max 2 |
    Write-RegEx -Name ToHash -CharacterClass Word -Repeat |
    Write-RegEx -CharacterClass Whitespace |
    Write-RegEx -Name Mode -CharacterClass Word -Repeat |
    Write-RegEx -Until (
        Write-RegEx '---' -StartAnchor LineStart
    ) |
    Write-RegEx -LiteralCharacter '-' -Min 3 -Max 3 |
    Write-RegEx -CharacterClass Whitespace |
    Write-RegEx -Name FromUnified -CharacterClass NonWhitespace -Repeat |
    Write-RegEx -CharacterClass Whitespace -Repeat|
    Write-RegEx -LiteralCharacter '+' -Min 3 -Max 3 |
    Write-RegEx -CharacterClass Whitespace |
    Write-RegEx -Name ToUnified -CharacterClass NonWhitespace -Repeat |
    Write-RegEx -CharacterClass Whitespace |
    Set-Content -Path (Join-Path $myRoot $myName)

