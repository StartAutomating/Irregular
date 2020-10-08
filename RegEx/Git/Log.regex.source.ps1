$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Pattern '(?m)' -Description "Matches Output from git log" |
Write-RegEx 'commit' -StartAnchor LineStart -Comment "Commits start with 'commit'" |
    Write-RegEx -CharacterClass Whitespace -Repeat |
    Write-RegEx -Pattern '?<HexDigits>' -Name CommitHash -Comment "The CommitHash is all hex digits after whitespace" |
    Write-RegEx -CharacterClass Whitespace -Repeat -Comment 'More whitespace (includes the newline)'|
    Write-RegEx -Optional -NoCapture @(
        Write-RegEx -Pattern 'Merge:' -Comment 'Next is the optional merge' |
            Write-RegEx -CharacterClass Whitespace -Repeat |
            Write-RegEx (
                Write-RegEx -Pattern (
                    Write-RegEx -Name MergeHash -Pattern '?<HexDigits>' |
                        Write-RegEx -Pattern '[\s-[\n\r]]' -Min 0 -Comment 'Which is hex digits, followed by optional whitespace'
                ) -NoCapture
            ) -Min 2
            Write-RegEx -CharacterClass NewLine, CarriageReturn -Repeat -Comment 'followed by a newline'
    ) |
    Write-RegEx -Pattern 'Author:' -Comment 'New is the author line' |
    Write-RegEx -CharacterClass Whitespace -Repeat |
    Write-RegEx -Name GitUserName -Until (
        Write-RegEx -Pattern '\s\<'
    ) -Comment 'The username comes before whitespace and a <' |
    Write-RegEx -CharacterClass Whitespace -Repeat |
    Write-RegEx -LiteralCharacter '<' -Comment 'The email is enclosed in <>' |
    Write-RegEx -Until ('>') -Name GitUserEmail |
    Write-RegEx -LiteralCharacter '>' |
    Write-RegEx -Until (Write-Regex -startAnchor LineStart 'date:') |
    Write-RegEx -Pattern 'Date:' -Comment 'Next comes the Date line' |
    Write-RegEx -CharacterClass Whitespace -Repeat |
    Write-RegEx -Until (Write-RegEx -CharacterClass NewLine) -Name CommitDate -Comment 'Since dates can come in many formats, capture the line' |
    Write-RegEx -CharacterClass NewLine | 
    Write-RegEx -Until ("(?>\r\n|\n){2,2}") -Name CommitMessage -Comment 'Anything until two newlines is the commit message' |#>
    Set-Content -Path (Join-Path $myRoot $myName)


