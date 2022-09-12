param(
[string]
$Tag,

[ValidateSet('Comment','Escaped','SectionStart','SectionEnd', 'Partial', 'Unescaped')]
[string[]]
$TagType
)

if (-not $tag) {
    $tag = @"
(?:.|\s){0,}?(?=\z|           # Now we match everything until
(?(IsEscaped)(\}{3})|(\}{2})) # 3 Brackets (if escaped) 2 (if not)
)                             
"@    
}

$mustBeType = $true

$tagTypeRegex = [Ordered]@{
    "Escaped"      = "\{", "# One more curly bracket marks it as escaped."
    "SectionStart" = "\#", "# Starting with a number sign makes it a section start."
    "SectionEnd"   = "\/", "# Starting with a slash makes it a section end."
    "Comment"      = "\!", "# Starting with an exclamation point makes it a comment."
    "Partial"      = "\>", "# Starting with greater than makes it a partial"
    "Unescaped"    = "\&", "# Unescaped variables start with ampersands."
}

if (-not $TagType) {
    $TagType = $TagTypeRegex.Keys
    $mustBeType = $false
}
$ValidTagTypes = 
    @(foreach ($tt in $tagTypeRegex.GetEnumerator()) {
        @(
            $tt.Value[1]
            "(?><Is$($tt.Key)>$($tt.Value[0]))"
        ) -join [Environment]::NewLine
    }) -join ([Environment]::NewLine + '|' + [Environment]::NewLine)

$ValidTagTypes = "(?>
$ValidTagTypes

)$(if (-not $mustBeType) { '?' })"
"
\{{2}                   # Two curly brackets start a tag
$ValidTagTypes
\s{0,}
(?<Variable>
$tag
)
# Once more, to be sure we're not at the end of the document.
(?(IsEscaped)(\}{3})|(\}{2})) # 3 Brackets (if escaped) 2 (if not)
"