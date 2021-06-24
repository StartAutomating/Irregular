<#
.Synopsis
    Matches Markdown Heading
.Description
    Matches Markdown Headings.  Can provide a -HeadingName, -HeadingLevel, and -IncludeContent.
#>
param(
# The name of the heading.  By default, will match any heading
[Parameter(ValueFromPipelineByPropertyName)]
[string]
$HeadingName = '[^#]+?',

# The level(s) of the heading.  If not provided, will match a heading of any level.
[ValidateRange(0,6)]
[int[]]
$HeadingLevel = 0,

# If set, will include the content of the heading.  This will match until the next heading start of any level.
[switch]
$IncludeContent
)

if (-not $HeadingLevel) {
    $HeadingLevel = 6..1
}

$HeadingLevel = $HeadingLevel | Sort-Object -Descending

"
(?m)                           # Set multline mode
^                              # Anchor at line start
\s{0,3}                        # Match Up to three whitespace characters, then one of:
(?>
"  + (@(
foreach ($hl in $HeadingLevel) {
    if ($hl -eq 1) {
@'
(?<HeadingName>\S.+?)$         # Match a line followed by
\s+                            # Some whitespace (in this case, the newline)
^\s{0,3}(?<h1>=+)\s{0,}$       # A line of all equals
'@
    } elseif ($hl -eq 2) {
@'
                               # Match SETEXT heading 1:
(?<HeadingName>\S.+?)$          
                               # A line of with at least one character of non-whitespace followed by
\s+                            # Some whitespace (in this case, the newline)
^\s{0,3}(?<h2>\-+)\s{0,}$      # A line of all dashes (with up to 3 leading spaces)
'@
    }
@"
                               # Match ATX heading $hl
(?<h$hl>\#{$hl})               
\s                             # A single whitespace followed by the heading name
(?<HeadingName>
$($HeadingName -replace '\s', '\s')
)
(?:[\#\s]{0,})$ # Ignore any remaining #s or whitespace"
"@
}


) -join ([Environment]::NewLine + (' ' * 4) + '|' + [Environment]::NewLine)) + '
)
' + $(
if ($IncludeContent) {
@"
(?<Content>                    # If including Content
    (?:.|\s){0,}?              # Match anything until
    (?=
        ^\s{0,3}               
        (?>                    # The start of another block
            [\#\-=~``]         
        )
        |                      # or
        \z                     # the end of the string.
    )
)
"@
}
)
