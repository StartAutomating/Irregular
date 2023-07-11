<#
.SYNOPSIS
    Matches a YAML key
.DESCRIPTION
    Matches a YAML key.  The -Key can be customized.
.EXAMPLE
    Get-Module Irregular | 
        Split-Path |
        Get-ChildItem -Recurse -Force -Filter *.yml | 
        ?<YAML_Key> -Key uses -IncludeInputObject |
        Foreach-Object {
            $_.InputObject | 
                ?<YAML_Value> -Text $y -StartAt $_.Index -Count 1
        }
#>
param(
# The key to match.  By default, this is any key.
[string]
$Key = '[^\:]+'
)

[Regex]::new(
$(
<#?<
New-RegEx -Description "Matches a YAML key" -Modifier Multiline -StartAnchor LineStart -Comment 'A key starts off a line' |
    New-RegEx -CharacterClass Whitespace -Min 0 -Comment 'Followed by whitespace' -Name Indent |
    New-Regex -Name InList (
    New-RegEx -LiteralCharacter '-' | 
        New-RegEx -CharacterClass Whitespace 
    ) -Optional -Comment 'Followed by an optional list start'
>#>
@'
# Matches a YAML key
(?m)^             # A key starts off a line
(?<Indent>\s){0,} # Followed by whitespace
(?<InList>\-\s)?  # Followed by an optional list start
'@ +
    [Environment]::NewLine +
    $Key + 
    [Environment]::NewLine
<#?<
New-RegEx -LiteralCharacter ':' -Comment 'Followed by colon'
>#>
@'
\: # Followed by colon
'@

),'IgnoreCase,IgnorePatternWhitespace','00:00:01'
)