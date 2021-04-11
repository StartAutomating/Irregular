$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Description "Matches an Email Address" |
    Write-RegEx -Name UserName -Pattern (
        Write-RegEx -CharacterClass Word -Comment "Match the username, which starts with a word character" |
            Write-RegEx -CharacterClass Word -LiteralCharacter '-.' -Min 0 -Comment "and can contain any number of word characters, dashes, or dots"
    ) |
    Write-RegEx -LiteralCharacter '@' -Comment "Followed by an @"|
    Write-RegEx -Name Domain -Pattern (
        Write-RegEx -CharacterClass Word  -Comment "The domain starts with a word character" |
            Write-RegEx -CharacterClass Word -LiteralCharacter '-' -Min 0 -Comment "and can contain any words with dashes," |
            Write-RegEx -NoCapture -Pattern (
                Write-RegEx -LiteralCharacter '.' -Comment "followed by at least one suffix (which starts with a dot),"|
                    Write-RegEx -CharacterClass Word -Comment "followed by a word character," |
                    Write-RegEx -CharacterClass Word -LiteralCharacter '-' -Min 0 -Comment "followed by any word characters or dashes"
            ) -Min 1
    ) |
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8


