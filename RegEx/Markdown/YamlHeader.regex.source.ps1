$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description @'
Matches a Markdown Yaml Header
'@ -Modifier Multiline -StartAnchor StringStart -LiteralCharacter '-' -Min 3 -Comment "At least 3 dashes mark the start of the YAML header" |
    Write-Regex -Name YAML -Until (
        Write-Regex -LiteralCharacter '-' -Min 3 -Comment "And anything until at least three dashes is the content"
    ) |
    Write-Regex -LiteralCharacter '-' -Min 3 -Comment "Include the dashes in the match, so that the pointer is correct." | 
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru

    