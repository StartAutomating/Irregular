$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Pattern '(?m)' |
    Write-RegEx -LiteralCharacter '@' -Min 2 -Max 2 -StartAnchor LineStart -NoCapture -Comment 'Two @s' |
    Write-RegEx -CharacterClass Whitespace -Min 1 -Comment Whitespace |
    Write-RegEx -LiteralCharacter '-' -Comment Dash |
    Write-RegEx -Name FromFileLineStart -CharacterClass Digit -Repeat -Comment From |
    Write-RegEx -LiteralCharacter ',' -Comment Comma  |
    Write-RegEx -Name FromFileLineCount -CharacterClass Digit -Repeat -Optional -Comment LineCount |
    Write-RegEx -CharacterClass Whitespace -Min 1 -Comment Whitespace |
    Write-RegEx -LiteralCharacter '+' -Comment Plus |
    Write-RegEx -Name ToFileLineEnd -CharacterClass Digit -Repeat -Comment To |
    Write-RegEx -LiteralCharacter ',' |
    Write-RegEx -Name ToFileLineCount -CharacterClass Digit -Repeat -Optional -Comment LineCount |
    Write-RegEx -CharacterClass Whitespace -Min 1 |
    Write-RegEx -LiteralCharacter '@' -min 2 -Max 2 -Comment 'Two More @s' |
    Write-RegEx -Name 'Header' -Until (Write-RegEx -EndAnchor LineEnd) -Optional |
    Write-RegEx -EndAnchor LineEnd |
    Set-Content -Path (Join-Path $myRoot $myName)
