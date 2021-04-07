$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description @'
Matches PowerShell ParameterSets (in [Parameter] and [CmdletBinding] attributes)
'@ -Pattern "ParameterSetName" -Comment " Find ParameterSetName" |
    Write-RegEx -CharacterClass Whitespace -Min 0 -Comment "Followed by optional whitespace" |
    Write-RegEx -LiteralCharacter '=' -Comment "Followed by an equals"|
    Write-RegEx -CharacterClass Whitespace -Min 0 -Comment "Followed by more optional whitespace" |
    Write-RegEx -LiteralCharacter '@' -Optional -Comment "Followed by an optional @" |
    Write-RegEx -Atomic -Or @(
        Write-RegEx -LiteralCharacter '"' |
            Write-RegEx -Not -LiteralCharacter '"' -Repeat -Name ParameterSetName -Comment "A ParameterSetName in a Double-Quoted String" |
            Write-RegEx -LiteralCharacter '"'

        Write-RegEx -LiteralCharacter "'" |
            Write-RegEx -Not -LiteralCharacter "'" -Repeat -Name ParameterSetName -Comment "A ParameterSetName in a String Quoted String" |
            Write-RegEx -LiteralCharacter "'"
    )|
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru

