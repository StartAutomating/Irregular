#requires -Module Irregular
$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Description "Matches GCode Instructions" -Modifier IgnoreCase -Not |
    Write-RegEx -CharacterClass Whitespace -Min 0 -Modifier Multiline -StartAnchor LineStart -Comment "Optional Whitespace after any newline" |    
    Write-RegEx -Description "Will match either a" -Atomic -Or @(
        Write-RegEx -Optional (
            Write-RegEx -LiteralCharacter ';' |
                Write-RegEx -Until "[\r\n]" -Name Comment -Comment "Literal ;, followed by anything until the next newline"
        )
        Write-RegEx -Name Instruction (
            Write-RegEx -Pattern '[\%A-Z]' -Name Letter |
            Write-RegEx -Pattern '\d+' -Name Number
        ) -Comment "An instruction, consisting of a letter and one or more numbers" |
            Write-RegEx -If Instruction -Then (
                Write-RegEx "(?:\s(?<Argument>[^\;\s]+)){0,}"
            ) -Comment "Instructions may be followed by one or more arguments, separated by spaces" |
            Write-RegEx -Pattern '[\s-[\r\n]]' -Min 0 -Comment "Match any trailing whitespace" |
            Write-RegEx -Optional -NoCapture (
                Write-RegEx -LiteralCharacter ';' |
                    Write-RegEx -Until "[\r\n]" -Name Comment
            ) -Comment "Match any trailing comments"
    ) | 
    Set-Content -Path (Join-Path $myRoot $myName) -PassThru



