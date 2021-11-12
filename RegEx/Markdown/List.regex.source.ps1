$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description @'
Matches a Markdown List
'@ -Modifier Multiline -StartAnchor LineStart  |    
    Write-RegEx -CharacterClass Whitespace -Min 0 -Name Indent -Comment "A list technically start with 0-3 characters spaces, but nested list items can have more than that" |
    Write-RegEx -Atomic -Or @(        
        Write-RegEx -CharacterClass Digit -Name Number | Write-RegEx -LiteralCharacter '.' -Comment "Followed by a dash, plus, or asterisk"
        Write-RegEx -LiteralCharacter '-+*' -Name BulletPoint -Comment "Followed by a dash, plus, or asterisk"
    ) |    
    Write-RegEx -CharacterClass Whitespace -Min 1 -Comment "Followed by at least one whitespace character" |
    Write-RegEx -Optional -Pattern (
        Write-RegEx -LiteralCharacter '[' |
            Write-RegEx -Atomic -Or @(
                Write-RegEx -Name Done    -Pattern x
                Write-RegEx -Name NotDone -Pattern \s 
            ) |
        Write-RegEx -LiteralCharacter ']'
    ) -Name IsTask -Comment "A list item can optionally be a task, in which case it will have brackets containing either an x or a space" |
    Write-RegEx -CharacterClass Whitespace -Min 0 |
    Write-RegEx -Until ( Write-RegEx -CharacterClass NewLine) -Name Value |
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru

    

