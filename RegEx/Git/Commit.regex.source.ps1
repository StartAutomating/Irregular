$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-Regex -Description "Matches Output from git commit" -Modifier Multiline |
New-Regex -LiteralCharacter '[' -Comment 'Initial Bracket' |
    New-Regex -Name Branch -CharacterClass NonWhitespace -Repeat -Comment 'Followed by the branch' |
    New-Regex -CharacterClass Whitespace -Comment 'then whitespace'|
    New-Regex -Name CommitHash -Pattern '[^\]]' -Repeat -Comment 'and then the commit hash'|
    New-Regex -Until (
        New-Regex -StartAnchor LineStart -CharacterClass Whitespace |
            New-Regex -CharacterClass Digit
    ) -Comment 'Match until a line that starts with a digit' |
    New-Regex -StartAnchor LineStart -CharacterClass Whitespace |
    New-Regex -CharacterClass Digit -Name FilesChanged -Repeat -Comment 'That digit is the number of files changed' |    
    New-Regex -Until (
        New-Regex -CharacterClass Digit -Repeat |
        New-Regex -Until '\+'
    ) -Comment 'Match until a digit, then until +' |
    New-Regex -CharacterClass Digit -Name Insertions  -Repeat -Comment 'That digit is the number of insertions' |
    New-Regex -Until (
        New-Regex -CharacterClass Digit -Repeat |
        New-Regex -Until '-'
    ) -Comment 'Match until a digit, then until -' |
    New-Regex -CharacterClass Digit -Name Deletions -Repeat -Comment 'That digit is the number of deletions' | 
    Set-Content -Path (Join-Path $myRoot $myName)
