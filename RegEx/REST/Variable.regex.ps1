<#
.Synopsis
    Matches a REST variable
.Description
    Matches variables within a RESTful URL.  Variables can take several forms:


#>
param(
# The variable formats.
[ValidateSet('Braces', 'Brackets','Tags','TickDollar','ColonStart')]
[string[]]
$VariableFormat = @('Braces', 'Brackets', 'Tags', 'TickDollar', 'ColonStart'),

[switch]
$NotInQuery
)

process {
$varForms = 
    foreach ($vf in $VariableFormat) {
        if ($vf -eq 'Braces') {@'
        \{(?<Variable>\w+)\}| # ... A <Variable> name in {} OR
'@      }
        if ($vf -eq 'Brackets') {@'
        \[(?<Variable>\w+)\]| #     A <Variable> name in [] OR
'@      }
        if ($vf -eq 'Tags') {@'
        \<(?<Variable>\w+)\>| #     A <Variable> name in <> OR
'@      }
        if ($vf -eq 'TickDollar') { @'
        `\$(?<Variable>\w+) | #     A `$ followed by a <Variable> OR
'@      }
        if ($vf -eq 'ColonStart') { @'
        \:(?<Variable>\w+)    #     A : followed by a <Variable>
'@      }
    }
@"
(?>                           # A variable can be in a URL segment or subdomain
    (?<Start>[/\.])           # Match the <Start>ing slash|dot ...
    (?<IsOptional>\?)?        # ... an optional ? (to indicate optional) ...
    (?:$([Environment]::NewLine + @($varForms -join [Environment]::newline))        
    )    
|
    (?<IsOptional>            # If it's optional it can also be 
        [{\[](?<Start>/)      # a bracket or brace, followed by a slash
    )
    (?<Variable>\w+)[}\]]     # then a <Variable> name followed by } or ]
$(if (-not $NotInQuery) { @"

|                             # OR it can be in a query parameter:
    (?<Start>[\?\&])          # Match The <Start>ing ? or & ...
    (?<Query>[\$\w\-]+)       # ... the <Query> parameter name ... 
    =                         # ... an equals ...
    (?<IsOptional>\?)?        # ... an optional ? (to indicate optional) ...
    (?:$([Environment]::NewLine + @($varForms -join [Environment]::newline))        
    )
"@})
)
"@
}