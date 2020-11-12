$myFile = $MyInvocation.MyCommand.ScriptBlock.File
$myName = ($myFile | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $myFile | Split-Path

Write-RegEx -StartAnchor LineStart -Modifier Multiline -Description 'Matches a File System Type (described in /proc/filesystems)' |
    Write-RegEx -Pattern nodev -Optional -Name NoDevice |
    Write-RegEx -CharacterClass Whitespace -Greedy -Lazy |
    Write-RegEx -Name FileSystemName -CharacterClass NonWhitespace -Repeat |
    Write-RegEx -Pattern '.*$' -NoCapture -Comment 'Then match until the end of the line.' |
    Set-Content -Path (Join-Path $myRoot $myName)

