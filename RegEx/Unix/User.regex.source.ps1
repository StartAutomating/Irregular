$myFile = $MyInvocation.MyCommand.ScriptBlock.File
$myName = ($myFile | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $myFile | Split-Path

Write-RegEx -StartAnchor LineStart -Modifier Multiline -Description 'Matches a User (described in /etc/passwd)' |
    Write-RegEx -Name Username '[^:]+' -Comment 'The Username is ' |
    Write-RegEx -LiteralCharacter ':' -Comment 'followed by a colon.'| 
    Write-RegEx -Name EncryptedPassword '[^:]+' -Comment 'The encrypted password is'|
    Write-RegEx -LiteralCharacter ':' -Comment 'followed by another colon.'|
    Write-RegEx -Name UserID -CharacterClass Digit -Repeat -Comment 'The user ID is a series of digits'|
    Write-RegEx -LiteralCharacter ':' -Comment 'followed by another colon' |
    Write-RegEx -Name UserGroupID -CharacterClass Digit -Repeat -Optional -Comment 'The user group ID is a series of digits '| 
    Write-RegEx -LiteralCharacter ':' -Comment 'followed by yet another colon' |
    Write-RegEx -Name FullUsername -Pattern '[^:]*?' -Comment 'The full username is anything until the next colon (and could be nothing)' |
    Write-RegEx -LiteralCharacter ':' -Comment 'Then another colon' |
    Write-RegEx -Name UserHomeDirectory -Pattern '[^:]*?' -Comment 'The home directory is anything until the next colon (and could be nothing)' |
    Write-RegEx -LiteralCharacter ':' -Comment 'Then one last colon'|
    Write-RegEx -Name LoginShell -Pattern '.*$' -Comment 'Anything until the end of the line is the login shell' |    
    Set-Content -Path (Join-Path $myRoot $myName)

