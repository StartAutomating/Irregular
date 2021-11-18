#requires -Module Irregular
$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Description "Matches Open SCAD Include statements" |
    Write-RegEx -Modifier Multiline -Comment 'Set Multiline mode.  Then,' |
    Write-RegEx -Pattern include -StartAnchor LineStart -Comment "match the literal 'include'" |
    Write-RegEx -CharacterClass Whitespace -Repeat -Comment 'and the obligitory whitespace.' |
    Write-RegEx -LiteralCharacter '<' |
    Write-RegEx -Not -literalcharacter '>' -Repeat -Name Include |
    Write-RegEx -Pattern '\>' |        
    Set-Content -Path (Join-Path $myRoot $myName) -PassThru
