<#
.Synopsis
    Matches a code block
.Description
    Matches a Markdown code block.  
    
    Code blocks can start/end with 3 or more backticks or tildas, or 4 indented whitespaces
#>
param(
# If set, will only match fenced code blocks.
[Parameter(ValueFromPipelineByPropertyName)]
[switch]
$Fenced,

# The languages
[Parameter(ValueFromPipelineByPropertyName)]
[Alias('InfoText')]
[string]
$Language
)

process {



    
$fencedBlock = 


@"
(?<FenceChar>[``\~]){3,}      # Code fences start with tildas or backticks, repeated at least 3 times
$(
if (-not $Language) {
@"
(?<Language>[\S]+)?           # Match an optional language (non-whitespace characters)
"@
} else {
@"
(?<Language>                  # Match a specific language
$language
)
"@
}
)
\s{0,}                        # Match but do not capture initial whitespace.
(?<Code>                      # Capture the <Code> block
    (?:.|\s){0,}?             # This is anything until
    (?=\z|\k<FenceChar>{3,})  # the end of the string or the same matching fence chars    
)
(?>\z|\k<FenceChar>{3,})
"@


$fourSpacesBlock = @"
(?m)
(^\s{4}(?<Code>\s{0,}\S.+?)$){1,} # Match one or more lines starting with at least four whitespace characters
"@

if ($Language) {
@"
(?>
    $($fencedBlock -join '
|
')
)
"@
} else {
@"
(?>
$($fencedBlock -join '
|
')
|
$fourSpacesBlock
)
"@
}

}
