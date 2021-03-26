$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description @'
Matches C/C++ #include 
'@ -Pattern "\#
include" -Comment " Match the include, followed by" |
    Write-RegEx -CharacterClass Whitespace -Repeat |
    Write-RegEx -Name Include -Atomic -Or @(
        Write-RegEx -Pattern '\<' -Comment 'A header, enclosed in <>s' |
            Write-RegEx -CharacterClass Word -LiteralCharacter '.\/' -Repeat -Name Header |
            Write-RegEx -Pattern '\>' -Comment 'OR'
               
        Write-RegEx -LiteralCharacter '"' -Comment 'A Source File, enclosed in ""s' |
            Write-RegEx -CharacterClass Word -LiteralCharacter '.\/' -Repeat -Name SourceFile |
        Write-RegEx -LiteralCharacter '"') |
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru

    