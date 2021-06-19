<#
.Synopsis
    Matches a JSON property
.Description
    Matches a JSON property.  -PropertyName can be customized.
#>
param(
[string]
$PropertyName = '.+?'
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


@"
(?<=             # After:
[\{\,]           # A bracket or comma
)
\s{0,}           # Optional Whitespace
(?<Quoted>["'])? # There's an optional opening quote
(?<Name>         # Capture the Name, which is:
$PropertyName    # The PropertyName or Anything Until...
)
(?=              
    (?(Quoted)   # If quoted
        ((?<!\\)\k<Quoted>) # the closing quote
        |
        ([\s:])  # otherwise, whitespace or a colon
    )
)
(?:              # Match but don't store:
    (?(Quoted)(\k<Quoted>))
\s{0,}     # a double-quote, optional whitespace:
)
(?=\:)      # Look ahead to see that we're followed by a :, but don't include it in the match.
:
(?<Value>
$jsonValue
)
"@