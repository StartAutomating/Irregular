<#
.Synopsis

.Description
    Matches specific fields from inline help
#>
param($Field = 'Description')
@"
\.(?<Field>$field)                   # Field Start
\s{0,}                               # Optional Whitespace
(?<Content>(.|\s)+?(?=(\.\w+|\#\>))) # Anything until the next .\field or end of the comment block
"@
