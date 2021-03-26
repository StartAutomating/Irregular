$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description @'
Matches C/C++ #define 
'@ -Pattern "\#
define" -Comment " Match the define" -Modifier Multiline|
    Write-RegEx -CharacterClass Whitespace -Repeat -Comment "Whitespace" | 
    Write-RegEx -Name Identifier -CharacterClass Word -Repeat -Comment "The identifier" |
    Write-RegEx -CharacterClass Whitespace -Min 0 -Comment "Optional Whitespace"|
    Write-RegEx -Atomic -Name Definition -Or @(
        Write-RegEx '[^\\]' -Repeat -EndAnchor LineEnd -Comment "A Line with no escape OR" 
        Write-RegEx -Min 1 (
            Write-RegEx -Name Line -Pattern '[^\\]+?\\' -Before '(?>\r\n|\n)' -Comment "One or more lines ending with \"
        )
    ) -Description "Then either" |#>
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru

    