$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description @'
Matches FFMpeg outputs
'@  -StartAnchor LineStart -Pattern "\s{0,}Output\s{0,}\#" -Comment "An Input starts with the literal 'Input', followed by a space a number sign" |
    Write-RegEx -Name FileNumber -CharacterClass Digit -Repeat -Comment "Followed by an file number and a comma" |
    Write-RegEx -LiteralCharacter ',' |
    Write-RegEx -CharacterClass Whitespace -Min 0 |
    Write-RegEx -NoCapture -Min 0 -Pattern (
        Write-RegEx -Name Container -Not -LiteralCharacter ',' -CharacterClass Whitespace -Repeat |
            Write-RegEx -LiteralCharacter ',' -Min 0
    ) -Comment "Followed by container information (separated by commas)" |
    Write-RegEx -CharacterClass Whitespace -LiteralCharacter ',' -Min 0 |
    Write-RegEx -Pattern 'to' -Comment "Followed by 'to'"  |
    Write-RegEx -CharacterClass Whitespace  -Min 0 |
    Write-RegEx -Pattern "(?<!\@)'(?<OutputPath>(?:''|\\'|[^'])*)'" -Comment "Followed by the OutputPath, in a single quoted string." |
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru

