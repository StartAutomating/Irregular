<#
.Synopsis
    Matches a JSON list item
.Description
    Matches a JSON list item.  If no -ListIndex is provided, will match all items in the list    
#>
param(
[int]
$ListIndex = -1
)


$jsonValue = @'
\s{0,}                            # Match preceeding whitespace
(?>                               # A JSON value can be:
    (?<IsTrue>true)               # 'true'
    |                             # OR
    (?<IsFalse>false)             # 'false'
    |                             # OR
    (?<IsNull>null)               # 'null'
    |                             # OR
    (?<Object>                    # an object, which is
        \{                        # An open brace
(?>                               # Followed by...
    [^\{\}]+|                     # any number of non-brace character OR
    \{(?<Depth>)|                 # an open brace (in which case increment depth) OR
    \}(?<-Depth>)                 # a closed brace (in which case decrement depth)
)*(?(Depth)(?!))                  # until depth is 0.
\}                                # followed by a closing brace
    )
    |                             # OR
    (?<List>                      # a list, which is
        \[                        # An open bracket
(?>                               # Followed by...
    [^\[\]]+|                     # any number of non-bracket character OR
    \[(?<Depth>)|                 # an open bracket (in which case increment depth) OR
    \](?<-Depth>)                 # a closed bracket (in which case decrement depth)
)*(?(Depth)(?!))                  # until depth is 0.
\]                                # followed by a closing bracket
    )
    |                             # OR
    (?<String>                    # A string, which is
        "                         # an open quote  
        .*?                       # followed by anything   
        (?=(?<!\\)"               # until the closing quote
    )
    |                             # OR
    (?<Number>                    # A number, which
        (?<Decimals>
(?<IsNegative>\-)?                # It might be start with a -
(?:(?>                            # Then it can be either: 
    (?<Characteristic>\d+)        # One or more digits (the Characteristic)
    (?:\.(?<Mantissa>\d+)){0,1}   # followed by a period and one or more digits (the Mantissa)
    |                             # Or it can be
    (?:\.(?<Mantissa>\d+))        # just a Mantissa      
))
(?:                               # Optionally, there can also be an exponent
    E                             # which is the letter 'e'  
    (?<Exponent>[+-]\d+)          # followed by + or -, followed by digits.
)?
)
    ) 
    )
)
\s{0,}                            # Optionally match following whitespace
'@

$listItemParams = @{} + $PSBoundParameters

if (-not $listItemParams.ContainsKey('ListIndex')) {
    @"
(?>
    \[\s{1,}\]                  # An open bracket
    |
    \[
        (?:
            (?<ListItem>
$jsonValue
            )
            (?:,)?
        ){1,}
    \]
)
"@
} elseif ($ListIndex -ge 0) {
    $findListIndex = @"
(?>    
    \[
        $(if ($ListIndex -ge 1) { @"
        (?:
            (?:$jsonValue)
            (?:,)?
        ){$listIndex}
        (?:,)?
"@    
})
(?<ListItem>
    $jsonValue
)
)
"@

    $findListIndex
}
