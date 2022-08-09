<#
.Synopsis
    Matches a PowerShell Help Field.
.Description
    Matches specific fields from inline help
#>
param(
    $Field = 'Description',

    $HelpFieldNames = @(
        'synopsis','description','link','example','inputs', 'outputs', 'parameter', 'notes'
    )
)

@"
\.(?<Field>$field)                   # Field Start
[\s-[\r\n]]{0,}                      # Optional Whitespace
(?<Content>
    (.|\s)+?(?=
        (
            \z  |
            \#\>|
            \.(?>$($fieldNames -join '|'))
        )
    )
) # Anything until the next .\field or end of the comment block
"@
