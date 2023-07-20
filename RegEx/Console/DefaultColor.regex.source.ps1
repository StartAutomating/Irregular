$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches an ANSI default color" -Modifier IgnoreCase -Not |
    New-RegEx -CharacterClass Escape -Comment 'An Escape' |
    New-RegEx -LiteralCharacter '[' -Comment 'Followed by a bracket' |
    New-RegEx -Name Color -Pattern (
        New-RegEx -Atomic -Or @(
            New-Regex -Name DefaultForeground -Pattern '39' -Comment '39 Represents the default foreground color' |
                New-RegEx -Pattern 'm'
            New-Regex -Name DefaultForeground -Pattern '49' -Comment '49 Represents the default background color' |
                New-RegEx -Pattern 'm'
        )                        
    ) |    
    Set-Content -Path (Join-Path $myRoot $myName)
