$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches an ANSI escape code" -Modifier IgnoreCase -Not |
    New-RegEx -CharacterClass Escape -Comment 'An Escape' |
    New-RegEx -LiteralCharacter '[' -Comment 'Followed by a bracket' |
    New-RegEx -Name ParameterBytes (
        New-Regex -CharacterClass Digit -LiteralCharacter ':;<=>?' -Min 0
    ) -Comment "Followed by zero or more parameter bytes" | 
    New-RegEx -Name IntermediateBytes (
        New-Regex -LiteralCharacter (0x21..0x2F -as [char[]]) -Min 0 -CharacterClass Whitespace
    ) -Comment "Followed by zero or more intermediate bytes" |
    New-RegEx -Name FinalByte (
        New-RegEx -LiteralCharacter (0x40..0x7E -as [char[]])
    ) -Comment "Followed by a final byte" |
    Set-Content -Path (Join-Path $myRoot $myName)
