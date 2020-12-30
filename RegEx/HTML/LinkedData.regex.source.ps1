$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path


Write-RegEx -Pattern '<script' -Description "Matches JSON Linked Data (JSON within HTML)" -Comment 'Match <script tag'|
    Write-Regex -CharacterClass Whitespace -Min 1 -Comment 'Then whitespace'|
    Write-RegEx -Pattern 'type=' -Comment 'Then the type= attribute (this regex will only match if it is first)' |
    Write-RegEx -LiteralCharacter "`"'" -Comment 'Double or Single Quotes' |
    Write-RegEx -Pattern 'application/ld\+json' -Comment 'The type that indicates linked data' |
    Write-RegEx -LiteralCharacter "`"'" -Comment 'Double or Single Quotes' |
    Write-RegEx -Pattern '[^>]' -Min 0  -Comment 'Match anything until the end of the start tag' |
    Write-RegEx -LiteralCharacter '>' -Comment 'Match the end of the start tag' |
    Write-RegEx -Until '</script>' -Name JsonContent -Comment 'Anything until the end tag is JSONContent' |
    Set-Content -Path (Join-Path $myRoot $myName)


