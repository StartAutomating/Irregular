$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches an ANSI 24-bit color" -Modifier IgnoreCase -Not |
    New-RegEx -CharacterClass Escape -Comment 'An Escape' |
    New-RegEx -LiteralCharacter '[' -Comment 'Followed by a bracket' |
    New-RegEx -Atomic -Or @(
        New-RegEx -Pattern '38' -Name IsForegroundColor
        New-RegEx -Pattern '48' -Name IsBackgroundColor
        New-RegEx -Pattern '58' -Name IsUnderlineColor
    ) |
    New-RegEx -Pattern ';2;' |
    New-RegEx -Name Color -Pattern (
        New-Regex -Name Red -Pattern '(?>[0-2][0-5][0-5]|[0-1]\d\d|\d{1,2})' -Comment 'Red is the first 0-255 value' |
        New-RegEx -Pattern ';' |
        New-Regex -Name Green -Pattern '(?>[0-2][0-5][0-5]|[0-1]\d\d|\d{1,2})' -Comment 'Green is the second 0-255 value' |
        New-RegEx -Pattern ';' |
        New-Regex -Name Blue -Pattern '(?>[0-2][0-5][0-5]|[0-1]\d\d|\d{1,2})' -Comment 'Blue is the third 0-255 value' |
        New-RegEx -Pattern 'm'
    ) |    
    Set-Content -Path (Join-Path $myRoot $myName)
