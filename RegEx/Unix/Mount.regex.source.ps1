$myFile = $MyInvocation.MyCommand.ScriptBlock.File
$myName = ($myFile | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $myFile | Split-Path

Write-RegEx -StartAnchor LineStart -Modifier Multiline -Description 'Matches a Unix Mount' |
    Write-RegEx -CharacterClass NonWhitespace -Repeat -Name Device -Comment 'Which is: A line start, followed by the device,' |
    Write-RegEx -CharacterClass Whitespace -Repeat -Comment 'followed by space,'|
    Write-RegEx -CharacterClass NonWhitespace -Repeat -Name MountPoint -Comment 'followed by the MountPoint,' |
    Write-RegEx -CharacterClass Whitespace -Repeat -Comment 'followed by space,' |
    Write-RegEx -CharacterClass NonWhitespace -Repeat -Name FileSystem -Comment 'followed by the FileSystem,' |
    Write-RegEx -CharacterClass Whitespace -Repeat -Comment 'followed by space.  Then each mount option' |
    Write-RegEx -Name MountOptions -Min 1 -Pattern (
        Write-RegEx -CharacterClass Whitespace -LiteralCharacter ',' -Not -Repeat -Name MountOption -Comment 'will be separated by a comma.'|
            Write-RegEx -Pattern '\,?' -NoCapture
    ) |
    Write-RegEx -Pattern '.*$' -NoCapture -Comment 'Then match until the end of the line.' |
    Set-Content -Path (Join-Path $myRoot $myName)
