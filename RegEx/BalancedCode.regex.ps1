<#
.Synopsis
    Matches Balanced Code
.Description
    Matches code balanced by a [, {, or (
#>
param(
[ValidateSet('[','{', '(')]
$Open = '{'
)

$close =
    if ($Open -eq '[') { ']' }
    elseif ($Open -eq '{') { '}' }
    elseif ($Open -eq '(') { ')' }
# Matches content in brackets, as long as it is balanced
@"
\$open              # An open bracket
(?>                 # Followed by...
    [^\$open\$close]+|       # any number of non-bracket character OR
    \$open(?<Depth>)|   # an open bracket (in which case increment depth) OR
    \$close(?<-Depth>)   # a closed bracket (in which case decrement depth)
)*(?(Depth)(?!))    # until depth is 0.
\$close             # followed by a closing bracket
"@