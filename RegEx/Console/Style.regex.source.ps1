$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches an ANSI style (color or text option)" |
    New-RegEx -Atomic -Or @(
        New-RegEx -Pattern '?<Console_Reset>'
        New-Regex -Pattern '?<Console_Bold>'
        New-Regex -Pattern '?<Console_Blink>'
        New-Regex -Pattern '?<Console_Faint>'
        New-Regex -Pattern '?<Console_Italic>'
        New-Regex -Pattern '?<Console_Invert>'
        New-Regex -Pattern '?<Console_Hide>'
        New-Regex -Pattern '?<Console_Strikethrough>'
        New-Regex -Pattern '?<Console_Underline>'
        New-RegEx -Pattern '?<Console_24BitColor>'
        New-RegEx -Pattern '?<Console_8BitColor>'
        New-RegEx -Pattern '?<Console_4BitColor>'        
        New-RegEx -Pattern '?<Console_DefaultColor>'
    ) |    
    Set-Content -Path (Join-Path $myRoot $myName) -PassThru
