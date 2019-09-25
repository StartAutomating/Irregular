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

$comment = 
    if ($open -eq '[') { 'bracket' }
    elseif ($open -eq '{')  { 'brace' }
    elseif ($Open -eq '(') { 'parenthesis' }

$close =
    if ($Open -eq '[') { ']' }
    elseif ($Open -eq '{') { '}' }
    elseif ($Open -eq '(') { ')' }
# Matches content in brackets, as long as it is balanced
@"
\$open              # An open $comment
(?>                 # Followed by...
    [^\$open\$close]+|       # any number of non-$comment character OR
    \$open(?<Depth>)|   # an open $comment (in which case increment depth) OR
    \$close(?<-Depth>)   # a closed $comment (in which case decrement depth)
)*(?(Depth)(?!))    # until depth is 0.
\$close             # followed by a closing $comment
"@