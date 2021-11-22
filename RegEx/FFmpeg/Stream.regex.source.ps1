$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description @'
Matches FFMpeg streams
'@  -StartAnchor LineStart -Pattern "\s{0,}Stream\s{0,}\#" -Comment "A Stream starts with the literal 'Stream', followed by a space a number sign" |
    Write-RegEx -Name FileNumber -CharacterClass Digit -Repeat -Comment "Followed by an file number and a colon" |
    Write-RegEx -LiteralCharacter ':' |
    Write-RegEx -Name StreamNumber -CharacterClass Digit -Repeat -Comment "Followed by a stream number and a colon" |
    Write-RegEx -LiteralCharacter ':' |
    Write-RegEx -CharacterClass Whitespace -Min 0 |
    Write-RegEx -Not -LiteralCharacter ':' -Name StreamType -Repeat -Comment "Followed by a stream type and a colon"|
    Write-RegEx -LiteralCharacter ':' |
    Write-RegEx -NoCapture -Min 0 -Pattern (
        Write-RegEx -CharacterClass Whitespace -Min 0 |
            Write-RegEx -Name Setting -Not -LiteralCharacter ',' -Repeat |
            Write-RegEx -LiteralCharacter ',' -Min 0 -Max 1
    ) -Comment "Followed by any number of settings, separated by commas" |
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru

