<#
.SYNOPSIS
    Matches a Markdown Link
.DESCRIPTION
    Matches a Markdown Link.  Can customize the link text and link url.
.NOTES
    This only matches simple markdown links.  It does not currently match links with titles.
#>
param(
# The text of the link.
$LinkText  = '[^\]\r\n]+',

# The link URI.
[Alias('LinkUrl')]
$LinkUri   = '[^\)\r\n]+'
)

@"
(?<IsImage>\!)?    # If there is an exclamation point, then it is an image link
\[                 # Markdown links start with a bracket 
(?<Text>$LinkText)
\]                 # anything until the end bracket is the link text.
\(                 # The link uri is within parenthesis
(?<Uri>$LinkUri)
\)                 # anything until the closing parenthesis is the link uri.
"@