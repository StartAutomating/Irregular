$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches an ANSI style (color or text option)" |
    New-RegEx -Atomic -Or @(
        New-RegEx -Pattern '?<ANSI_Reset>'
        New-Regex -Pattern '?<ANSI_Bold>'
        New-Regex -Pattern '?<ANSI_Blink>'
        New-Regex -Pattern '?<ANSI_Faint>'
        New-Regex -Pattern '?<ANSI_Italic>'
        New-Regex -Pattern '?<ANSI_Invert>'
        New-Regex -Pattern '?<ANSI_Hide>'
        New-Regex -Pattern '?<ANSI_Strikethrough>'
        New-Regex -Pattern '?<ANSI_Underline>'
        New-RegEx -Pattern '?<ANSI_24BitColor>'
        New-RegEx -Pattern '?<ANSI_8BitColor>'
        New-RegEx -Pattern '?<ANSI_4BitColor>'        
        New-RegEx -Pattern '?<ANSI_DefaultColor>'
    ) |    
    Set-Content -Path (Join-Path $myRoot $myName) -PassThru
