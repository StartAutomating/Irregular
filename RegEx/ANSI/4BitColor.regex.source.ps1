$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches an ANSI 3 or 4-bit color" |
    New-RegEx -CharacterClass Escape -Comment 'An Escape' |
    New-RegEx -LiteralCharacter '[' -Comment 'Followed by a bracket' |
    New-RegEx -Pattern (
        
        New-RegEx -Atomic -Or @(
            New-RegEx -Pattern 1 -Optional -Name IsBright |
                New-RegEx -LiteralCharacter ';' -Min 0 -Max 1 |    
                New-RegEx -Pattern '3' -Name IsForegroundColor
            
            New-RegEx -Name IsBright (
                New-RegEx -Pattern '9' -Name IsForegroundColor
            )
            
            New-RegEx -Pattern 1 -Optional -Name IsBright |
                New-RegEx -LiteralCharacter ';' -Min 0 -Max 1 |
                New-RegEx -Pattern '4' -Name IsBackgroundColor

            New-RegEx -Name IsBright (
                New-RegEx -Pattern '10' -Name IsBackgroundColor
            )
        ) |
        New-RegEx -Pattern '[0-7]' -Name ColorNumber |
        New-RegEx -LiteralCharacter 'm'
    ) -Name Color | #>   
    Set-Content -Path (Join-Path $myRoot $myName)
