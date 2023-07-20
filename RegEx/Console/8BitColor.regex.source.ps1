$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches an ANSI 8-bit color" -Modifier IgnoreCase -Not |
    New-RegEx -CharacterClass Escape -Comment 'An Escape' |
    New-RegEx -LiteralCharacter '[' -Comment 'Followed by a bracket' |
    New-RegEx -Atomic -Or @(
        New-RegEx -Pattern '38' -Name IsForegroundColor
        New-RegEx -Pattern '48' -Name IsBackgroundColor
        New-RegEx -Pattern '58' -Name IsUnderlineColor
    ) |
    New-RegEx -Pattern ';5;' |
    New-RegEx -Name Color -Pattern (
        New-RegEx -Atomic -Or @(            
            New-Regex -Name StandardColor -Pattern '[0-7]' -Comment '0 -7 are standard colors' |
                New-RegEx -Pattern m
            New-Regex -Name BrightColor -Pattern '(?>[8-9]|1[0-5])' -Comment '8-15 are bright colors' |
                New-RegEx -Pattern m
            New-Regex -Name CubeColor -Pattern '(?>[0-2][0-3][0-1]|[0-1]\d\d|\d{1,2})' -Comment '16-231  are cubed colors' |
                New-RegEx -Pattern m
            New-Regex -Name GrayscaleColor -Pattern '(?>[0-2][0-5][0-5]|[0-1]\d\d|\d{1,2})' -Comment '232-255 are grayscales' |
                New-RegEx -Pattern m
        )
    ) |    
    Set-Content -Path (Join-Path $myRoot $myName)
