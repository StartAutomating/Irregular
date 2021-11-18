#requires -Module Irregular
$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Description "Matches OpenSCAD Use statements" |
    Write-RegEx -Modifier Multiline -Comment 'Set Multiline mode.  Then,' |
    Write-RegEx -Pattern use -StartAnchor LineStart -Comment "match the literal 'use'" |
    Write-RegEx -CharacterClass Whitespace -Repeat -Comment 'and the obligitory whitespace.' |
    Write-RegEx -LiteralCharacter '<' |
    Write-RegEx -Not -literalcharacter '>' -Repeat -Name Use |
    Write-RegEx -Pattern '\>' |        
    Set-Content -Path (Join-Path $myRoot $myName) -PassThru
