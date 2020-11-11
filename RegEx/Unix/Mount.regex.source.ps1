$myFile = $MyInvocation.MyCommand.ScriptBlock.File
$myName = ($myFile | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $myFile | Split-Path

Write-RegEx -StartAnchor LineStart -Modifier Multiline -Description 'Matches a Unix Mount' |
    Write-RegEx -CharacterClass NonWhitespace -Repeat -Name Device -Comment 'Which is: A line start, followed by the device,' |
    Write-RegEx -CharacterClass Whitespace -Repeat -Comment 'followed by space,' |
    Write-RegEx -NoCapture -Optional -Pattern 'on\s' -Comment "and possibly, the word 'on'," |
    Write-RegEx -CharacterClass NonWhitespace -Repeat -Name MountPoint -Comment 'followed by the MountPoint,' |
    Write-RegEx -CharacterClass Whitespace -Repeat -Comment 'followed by space,' |
    Write-RegEx -NoCapture -Optional -Pattern 'type\s' -Comment "and possibly, the word 'type'," |
    Write-RegEx -CharacterClass NonWhitespace -Repeat -Name FileSystem -Comment 'followed by the FileSystem,' |
    Write-RegEx -CharacterClass Whitespace -Repeat -Comment 'followed by space.' |
    Write-Regex -LiteralCharacter '(' -NoCapture -Optional -Comment 'Then, optionally, an open parenthesis.' |
    Write-RegEx -Name MountOptions -Pattern (
    Write-RegEx -NoCapture -Pattern @(
        Write-RegEx -CharacterClass Whitespace -LiteralCharacter ',' -Optional -Comment 'will be separated by an optional comma'|
        Write-RegEx -Atomic -Pattern @(
            Write-RegEx -CharacterClass Digit -Name DumpFrequency -Comment 'If the mount option started with a digit, it is the DumpFrequency' |
                Write-RegEx -CharacterClass Whitespace |
                Write-RegEx -CharacterClass Digit -Name PassNumber -Comment 'and it will be followed by the PassNumber'
                
            Write-RegEx -LiteralCharacter ',)' -CharacterClass Whitespace -Not -Repeat -Name MountOption -Comment 'Otherwise, the mount option is anything until the next comma or )'
        ) -Or |
        Write-RegEx -LiteralCharacter ')' -Optional
    ) -Description 'Each mount option' |
        Write-RegEx -Min 1
) |
    <#Write-RegEx -Pattern @'
(?<MountOptions>
    [,\s]?
    (?<MountOption>[^,)\s]+)
){1,}
'@ |#>
    Write-RegEx -Pattern '.*$' -NoCapture -Comment 'Then match until the end of the line.' |
    Set-Content -Path (Join-Path $myRoot $myName)
