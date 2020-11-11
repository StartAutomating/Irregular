$myFile = $MyInvocation.MyCommand.ScriptBlock.File
$myName = ($myFile | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $myFile | Split-Path

Write-RegEx -Modifier Multiline -Description "Matches Lines in a .conf or .ini file." -Comment 'Set Multiline mode' |
    Write-RegEx -Pattern @(
        Write-RegEx -StartAnchor LineStart  -LiteralCharacter ';#' |
            Write-RegEx -Until (Write-Regex -EndAnchor LineEnd) -Name Comment -Comment 'Lines that start with ; or # are comments'

        Write-RegEx -CharacterClass Whitespace -Repeat -StartAnchor LineStart -EndAnchor LineEnd -Comment 'Blank lines will also match, but not be captured'

        Write-RegEx -StartAnchor LineStart -CharacterClass Word, Whitespace -LiteralCharacter .- -Repeat -Name Key -Comment 'Otherwise, the first word is the name' |
            Write-RegEx -CharacterClass Whitespace -Optional |
            Write-RegEx -LiteralCharacter =: -Name Delimeter -Comment 'Followed by an equals or colon (surrounded by optional whitespace)'|
            Write-RegEx -CharacterClass Whitespace -Optional |
            Write-RegEx -Until (Write-Regex -EndAnchor LineEnd) -Name Value -Comment 'Anything until the end of line is the value'
    
        Write-RegEx -StartAnchor LineStart -EndAnchor LineEnd -CharacterClass Any -Name Line
    
    ) -Or -Description 'A Configuration line can either be a comment line, a blank line, or a line with a value' | 
    Set-Content -Path (Join-Path $myRoot $myName)



