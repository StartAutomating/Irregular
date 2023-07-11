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
(?<=
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
)
'@
<#?<
New-RegEx -Atomic -Or @(        
        New-RegEx -Atomic -Or @(
        
            New-RegEx -Name IsChild -Pattern (
                New-RegEx -Before '[\r\n]{1,2}\k<Indent>\s{2}'
            ) -Optional |
                New-RegEx -Name Value (
                    New-RegEx -NoCapture -Min 1 (
                        New-RegEx -Pattern '[\r\n]{1,2}' |
                        New-RegEx -Backreference Indent |
                        New-RegEx -Atomic -Or @(
                            New-RegEx -Pattern '\-\s'
                            New-RegEx -Pattern '\s{2}'
                        ) |
                        New-RegEx -Pattern '[^\r\n]{1,}'
                    )
                )

            New-RegEx -Pattern "[\s-[\r\n]]" -Comment "Inline values start with a single space" |
                New-Regex -Atomic -Or @(
                    New-RegEx -Name IsBlock -Pattern '\|(?>\+|\-)?(?=[\r\n]{1,2})' -Optional |
                    New-RegEx -Name Value (
                        New-RegEx -NoCapture -Min 1 (
                            New-RegEx -Pattern '[\r\n]{1,2}' |
                            New-RegEx -Backreference Indent |
                            New-RegEx -Atomic -Or @(
                                New-RegEx -Pattern '\-\s'
                                New-RegEx -Pattern '\s{2}'
                            ) |
                            New-RegEx -Pattern '[^\r\n]{1,}'
                        )
                    )

                    

                    New-RegEx -Name ValueInline (
                        New-RegEx -Not -LiteralCharacter "'`"" -CharacterClass NewLine, CarriageReturn -Repeat -Name Value -Comment "An unquoted value"
                    )

                    New-RegEx -LiteralCharacter "'" |
                        New-RegEx -Until (
                            New-RegEx -NotAfter "'" |
                                New-RegEx -LiteralCharacter "'"
                        ) -Name Value |
                        New-RegEx -LiteralCharacter "'" -Comment "OR a single quoted value"

                    New-RegEx -LiteralCharacter '"' |
                        New-RegEx -Until (
                            New-RegEx -NotAfter '\\' |
                                New-RegEx -LiteralCharacter '"'
                        ) -Name Value |
                        New-RegEx -LiteralCharacter '"' -Comment "OR a double quoted value"
                )                                                    
        )
    )
>#>
@'
(?>
  (?>
  (?<IsChild>(?=[\r\n]{1,2}\k<Indent>\s{2}))?(?<Value>(?:[\r\n]{1,2}\k<Indent>(?>
  \-\s  |
  \s{2})[^\r\n]{1,}){1,})  |
  [\s-[\r\n]]                                   # Inline values start with a single space
(?>
  (?<IsBlock>\|(?>\+|\-)?(?=[\r\n]{1,2}))?(?<Value>(?:[\r\n]{1,2}\k<Indent>(?>
  \-\s  |
  \s{2})[^\r\n]{1,}){1,})  |
  (?<ValueInline>(?<Value>[^\n\r\'\"]+)         # An unquoted value
)  |
  \'(?<Value>(?:.|\s){0,}?(?=\z|(?<!')\'))\'    # OR a single quoted value
  |
  \"(?<Value>(?:.|\s){0,}?(?=\z|(?<!\\)\"))\"   # OR a double quoted value
)))
'@
),'IgnoreCase,IgnorePatternWhitespace','00:00:01'
)