function Write-RegEx
{
    <#
    .Synopsis
        Writes a regular expression
    .Description
        Helps to simplifify writing regular expressions
    .Link
        Use-RegEx
    .Example
        Write-RegEx -CharacterClass Any -Repeat
    .Example
        Write-Regex -CharacterClass Digit -Repeat -Name Digits
    .Example
        # A regular expression for a quoted string (with \" and `" as valid escape sequences)
        Write-RegEx -Pattern '"' |
                Write-RegEx -CharacterClass Any -Repeat -Lazy -Before (
                    Write-RegEx -Pattern '"' -NotAfter '\\|`'
                ) |
                Write-RegEx -Pattern '"'
    .Example
        # A regular expression for an email address. ?<> is an alias for Write-Regex

        ?<> -Name EmailAddress -Pattern (
            ?<> -CharacterClass Word |
            ?<> -LiteralCharacter -. -CharacterClass Word -Min 0
        ) |
            ?<> -LiteralCharacter '@' -NoCapture |
            ?<> -Name Domain -Pattern (
                ?<> -CharacterClass Word |
                ?<> -LiteralCharacter - -CharacterClass Word -Min 0 |
                ?<> -LiteralCharacter . |
                ?<> -CharacterClass Word -Min 1
            )
    .Example
        # Writes a pattern for multiline comments
        Write-RegEx -Pattern \<\# |
            Write-RegEx -Name Block -Until \#\> |
            Write-RegEx -Pattern \#\>
    #>
    [OutputType([Regex], [PSObject])]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSPossibleIncorrectComparisonWithNull", "", Justification="This is explicitly checking for null (lazy -If would miss 0)")]
    param(
    # One or more regular expressions.
    [Parameter(Position=0)]
    [Alias('Expression')]
    [string[]]
    $Pattern,

    # One or more character classes.
    [Alias('CC','CharacterClasses')]
    [ValidateSet(
        'Any', '.',
        'Word', '\w',
        'NonWord', '\W',
        'Whitespace', '\s',
        'NonWhitespace', '\S',
        'Digit', '\d',
        'NonDigit', '\D',
        'Escape', '\e',
        'Tab', '\t',
        'CarriageReturn', '\r',
        'NewLine', '\n',
        'VerticalTab', '\v',
        'FormFeed', '\f',
        'UpperCaseLetter', '\p{Lu}',
        'LowerCaseLetter', '\p{Ll}',
        'TitleCaseLetter', '\p{Lt}',
        'ModifierLetter' , '\p{Lm}',
        'OtherLetter' , '\p{Lo}',
        'Letter' , '\p{L}',
        'NonSpacingMark' ,'\p{Mn}',
        'CombiningMark' ,'\p{Mc}',
        'EnclosingMark' , '\p{Me}',
        'Mark' , '\p{M}',
        'Number' , '\p{N}',
        'NumberDecimalDigit' , '\p{Nd}',
        'NumberLetter' , '\p{Nl}',
        'NumberOther' , '\p{No}',
        'PunctuationConnector' , '\p{Pc}',
        'PunctuationDash' , '\p{Pd}',
        'PunctuationOpen' , '\p{Ps}',
        'PunctuationClose' , '\p{Pe}',
        'PunctuationInitialQuote' , '\p{Pi}',
        'PunctuationFinalQuote' , '\p{Pf}',
        'PunctuationOther' , '\p{Po}',
        'Punctuation' , '\p{P}',
        'SymbolMath' ,'\p{Sm}',
        'SymbolCurrency' ,'\p{Sc}',
        'SymbolModifier' ,'\p{Sk}',
        'SymbolOther' ,'\p{So}',
        'Symbol' , '\p{S}',
        'SeparatorSpace' ,'\p{Zs}',
        'SeparatorLine' , '\p{Zl}',
        'SeparatorParagraph' , '\p{Zp}',
        'Separator' , '\p{Z}',
        'Control' , '\p{C}',
        'NonUpperCaseLetter', '\P{Lu}',
        'NonLowerCaseLetter', '\P{Ll}',
        'NonTitleCaseLetter', '\P{Lt}',
        'NonModifierLetter' , '\P{Lm}',
        'NonOtherLetter' , '\P{Lo}',
        'NonLetter' , '\P{L}',
        'NonNonSpacingMark' ,'\P{Mn}',
        'NonCombiningMark' ,'\P{Mc}',
        'NonEnclosingMark' , '\P{Me}',
        'NonMark' , '\P{M}',
        'NonNumber' , '\P{N}',
        'NonNumberDecimalDigit' , '\P{Nd}',
        'NonNumberLetter' , '\P{Nl}',
        'NonNumberOther' , '\P{No}',
        'NonPunctuationConnector' , '\P{Pc}',
        'NonPunctationDash' , '\P{Pd}',
        'NonPunctationOpen' , '\P{Ps}',
        'NonPunctationClose' , '\P{Pe}',
        'NonPunctationInitialQuote' , '\P{Pi}',
        'NonPunctationFinalQuote' , '\P{Pf}',
        'NonPunctuationOther' , '\P{Po}',
        'NonPunctuation' , '\P{P}',
        'NonSymbolMath' ,'\P{Sm}',
        'NonSymbolCurrency' ,'\P{Sc}',
        'NonSymbolModifier' ,'\P{Sk}',
        'NonSymbolOther' ,'\P{So}',
        'NonSymbol' , '\P{S}',
        'NonSeparatorSpace' ,'\P{Zs}',
        'NonSeparatorLine' , '\P{Zl}',
        'NonSeparatorParagraph' , '\P{Zp}',
        'NonSeparator' , '\P{Z}',
        'NonControl' , '\P{C}'
    )]
    [string[]]
    $CharacterClass,

    [Alias('LC','LiteralCharacters')]
    [string[]]
    $LiteralCharacter,

    # If provided, will name the capture
    [Alias('CaptureName')]
    [string]
    $Name,

    # The name or number of a backreference (a reference to a previous capture)
    [string]$Backreference,

    # A negative lookbehind (?<!). This pattern that must not match after the current position..
    [Alias('NegativeLookBehind')]
    [string]
    $NotAfter,

    # A negative lookahead (?!). This pattern must not match before the current position.
    [Alias('NegativeLookAhead')]
    [string]
    $NotBefore,

    # A positive lookbehind (?<=). This pattern that must match after the current position.
    [Alias('LookBehind')]
    [string]
    $After,

    # A positive lookahead (?=). This pattern that must match before the current position.
    [Alias('LookAhead')]
    [string]
    $Before,

    # If set, will match repeated occurances of a character class or pattern
    [Alias('Repeating')]
    [switch]
    $Repeat,

    # If set, repeated occurances will be matched greedily.
    # A greedy match is the last possible match that completes a condition.
    # For example when you run "abcabc" -match 'a.*c' (a greedy match)
    # $matches will be abcabc
    [switch]
    $Greedy,

    # If set, repeated occurances will be matched lazily.
    # A lazy match is the first possible match that completes a conidition.
    # For example, when you run "abcabc" -match 'a.*?c' (a lazy match)
    # $matches will be abc
    [switch]
    $Lazy,

    # The minimum number of repetitions.
    [Alias('AtLeast')]
    [int]$Min,

    # The maximum number of repetitions.
    [Alias('AtMost')]
    [int]$Max,

    # If provided, inserts a Regular Expression conditional.
    [Alias('IfExpression')]
    [string]$If,

    # If the pattern provided in -If is true, it will attempt to continue to match with the pattern provided in -Then
    [Alias('ThenExpression')]
    [string[]]$Then,

    # If the pattern provided in -If if false, it will attempt to continue to match the with the pattern provided in -Else.
    [Alias('ElseExpression')]
    [string[]]$Else,

    # If provided, will match all content until any of these conditions or the end of the string are found.
    [string[]]$Until,

    # A comment (yes, they exist in Regular Expressions)
    [string]$Comment,

    # A description.  This will be added to the top of the expression as a comment.
    [string]$Description,

    # If set and -CharacterClass is provided, will match anything but the provided set of character classes.
    # If set and -Expression is provided, will match anything that does not contain the expression
    # If set and neither -Expression or -CharacterClass is provided, will do an empty lookbehind (this will always fail)
    [switch]
    $Not,

    # If set, will match any of a number of character classes, or any number of patterns.
    [switch]
    $Or,

    # The start anchor.
    [ValidateSet(
        'Boundary', '\b',
        'NotBoundary', '\B',
        'LineStart', '^',
        'LineEnd', '$',
        'StringStart', '\A',
        'StringEnd', '\z',
        'LastLineEnd', '\Z'
    )]
    [string]
    $StartAnchor,

    # The end anchor.
    [ValidateSet(
        'Boundary', '\b',
        'NotBoundary', '\B',
        'LineStart', '^',
        'LineEnd', '$',
        'StringStart', '\A',
        'StringEnd', '\z',
        'LastLineEnd', '\Z'
    )]
    [string]
    $EndAnchor,

    # If set, will make the pattern optional
    [switch]
    $Optional,

    # If set, will make the pattern atomic.  This will allow one and only one match.
    [switch]
    $Atomic,

    # # If set, will make the pattern non-capturing.  This will omit the group from the resulting match.
    [Alias('NonCapturing','NoCap')]
    [switch]
    $NoCapture,

    # A regular expression that occurs before the generated regular expression.
    [Parameter(ValueFromPipeline)]
    [Alias('PreExpression')]
    [string[]]
    $PrePattern,

    # The timeout of the regular expression.  By default, 5 seconds.
    [TimeSpan]
    $TimeOut = '00:00:05',

    # If provided, will match between a given string or pair of strings.
    [string[]]
    $Between,

    # The escape sequence used with -Between.  By default, a slash
    [string]
    $EscapeSequence = '\\',

    # If set, comments in the regular expression will not be normalized.
    # By default, all comments that do not start on the beginning are normalized to start at the same column.
    [switch]
    $Denormalized,

    # Named parameters.  These are only valid if the regex is using a Generator script.
    [Alias('Parameters')]
    [Collections.IDictionary]
    $Parameter = @{},

    # A list of arguments.  These are only valid if the regex is using a Generator script.
    [Alias('Arguments','Args')]
    [PSObject[]]$ArgumentList = @()
    )

    begin {
        $ccLookup = @{}

        foreach ($paramName in 'CharacterClass', 'StartAnchor', 'EndAnchor') {
            $vvl =
                foreach ($attr in $MyInvocation.MyCommand.Parameters[$paramName].Attributes) {
                   if (-not $attr.ValidValues) { continue }
                   $attr.ValidValues
                   break
                }

            for ($i = 0; $i -lt $vvl.Count; $i+= 2) {
                $ccLookup[$vvl[$i]] = $vvl[$i + 1]
                $ccLookup[$vvl[$i + 1]] = $vvl[$i + 1]
            }
        }

        $SavedCaptureReferences = [Regex]::new(@'
(\(\?\<(?<NewCaptureName>\w+)\>)?
(?<!\()                   # Not preceeded by a (
\?\<(?<CaptureName>\w+)\> # ?<CaptureName>
(?<HasArguments>
    (?:
        \((?<Arguments>     # An open parenthesis
        (?>                 # Followed by...
            [^\(\)]+|       # any number of non-parenthesis character OR
            \((?<Depth>)|   # an open parenthesis (in which case increment depth) OR
            \)(?<-Depth>)   # a closed parenthesis (in which case decrement depth)
        )*(?(Depth)(?!))    # until depth is 0.
        )\)                  # followed by a closing parenthesis
    )|
    (?:
        \{(?<Arguments>     # An open bracket
        (?>                 # Followed by...
            [^\{\}]+|       # any number of non-bracket character OR
            \{(?<Depth>)|   # an open bracket (in which case increment depth) OR
            \}(?<-Depth>)   # a closed bracket (in which case decrement depth)
        )*(?(Depth)(?!))    # until depth is 0.
        )\}             # followed by a closing bracket
    )
)?
'@, 'IgnoreCase, IgnorePatternWhitespace', '00:00:01')


        $replaceSavedCapture = {
            $m = $args[0]
            $startsWithCapture = '(?<StartsWithCapture>\A\(\?\<(?<FirstCaptureName>\w+))>'
            $regex = $script:_RegexLibrary.($m.Groups["CaptureName"].ToString())
            if (-not $regex) { return $m }
            $regex =
                if ($regex -isnot [Regex]) {
                    if ($m.Groups["Arguments"].Success) {
                        $args = @($m.Groups["Arguments"].ToString() -split '(?<!\\),')
                        & $regex @args
                    } else {
                        & $regex
                    }
                } else {
                    $regex
                }
            if ($m.Groups["NewCaptureName"].Success) {
                if ($regex -match $startsWithCapture -and
                    $matches.FirstCaptureName -ne $m.Groups['NewCaptureName']) {
                    $repl= $regex -replace $startsWithCapture, "(?<$($m.Groups['NewCaptureName'])>"
                    $repl.Substring(0, $repl.Length - 1) + [Environment]::NewLine
                }
            } else {
                "$regex" + [Environment]::NewLine
            }
        }


        $startsWithCapture = [Regex]::new(
            '(?<StartsWithCapture>\A\(\?\<(?<FirstCaptureName>\w+))>',
            'IgnoreCase,IgnorePatternWhitespace', '00:00:01')
    }
    process {
        $myParams = @{} + $PSBoundParameters
        #region Generate RegEx
        $regex = . {

            $theOC = 0

            if ($PrePattern) { # If we've been provided a pre-expression, this goes first.
                $prePattern -join ''
            }
            if ($Description) {
                if ($prePattern -and -not $prePattern[-1].EndsWith([Environment]::NewLine)) {
                    [Environment]::NewLine
                }
                @(foreach ($l in $Description -split ([Environment]::NewLine)) {
                    "# $($l.TrimStart('#'))"
                }) -join ([Environment]::NewLine)
                [Environment]::NewLine
            }

            if ($Between) {
                if ($between.Length -gt 2) {
                    Write-Error 'Can pass only one or two -Between'
                    return
                }
                $firstBetween, $secondBetween = $between
                $escapePattern =
                    if ($EscapeSequence) {
                        if ($EscapeSequence -ne ($firstBetween * 2)) {
                            "(?<!$escapeSequence)"
                        } else {
                            ''
                        }

                    } else { '' }

                "(?:" + $escapePattern + $firstBetween

                if (-not $pattern) {
                    if (-not $secondBetween) {
                        $secondBetween = $firstBetween
                    }
                    if ($escapeSequence -ne ($firstBetween * 2)) {
                        $pattern = "(?:.|\s)*?(?=\z|${escapePattern}${secondBetween})"
                    } else {

                        $pattern = "(?:$escapeSequence|[^$firstBetween])*(?=\z|$secondBetween)"
                    }

                }
                $theOC++
            }

            if ($Atomic) {
                "(?>"; $theOC++
            }

            if ($NoCapture) {
                "(?:"; $theOC++
            }

            if ($Name) { # If the capture has a name, add it.
                "(?<$Name>"; $theOC++
            }

            if ($StartAnchor) { # Then add start anchors
                $ccLookup[$startAnchor]
            }

            if ($NotAfter) { # Then put negative lookbehind
                "(?<!$NotAfter)"
            }

            if ($After) { # and positive lookbehind.
                "(?<=$after)"
            }

            if ($Backreference) { # Then add backrefencees
                if ($backreference -as [int] -ne $null) {
                    "\$($backreference -as [int])"
                } else {
                    "\k<$backreference>"
                }
            }

            if ($Pattern) {
                $Pattern =
                    foreach ($expr in $Pattern) { # Now handle any expressions they passed in.
                        $SavedCaptureReferences.Replace($expr, $replaceSavedCapture)
                    }

                if ($Or -and $Pattern.Length -gt 1) { # (join multiples with | if -Of is passed)
                    "($($Pattern -join '|'))"
                }
                elseif ($Not) { "\A((?!($($Pattern -join ''))).)*\Z" } # (create an antipattern if -Not is passed)
                elseif ($pattern.Length -gt 1 -and # If more than one pattern was passed
                    ($repeat -or $greedy -or $lazy -or $optional -or ($min -ge 0))) { # and we're interested in repetitions
                    "(?:$($pattern))" # put the pattern in a non-capturing group[
                }
                else { $Pattern }
            }

            if ($until) {
                if ($until -notlike '\z*') {
                    $until = @("\z") + $until
                }
                "(?:.|\s)+?(?=$($until -join '|'))"
            }

            if ($CharacterClass -or $LiteralCharacter) { # If we're passed in a character class
                $cout =
                    @(foreach ($cc in $CharacterClass) { # find them in the lookup table
                        $ccLookup[$cc]
                    })

                $lc = @($literalCharacter -replace '[\p{P}\p{S}]', '\$0')
                $charSet = @($cout + $lc) -ne ''

                if ($not) # I -Not was passed
                {
                    "[^$($charSet -join '')]" # It can be any character that is not in any of the character classes.
                }
                # If we have more than one character class
                elseif ($charSet.Length -gt 1 -or ($literalCharacter -and $literalCharacter[0].Length -gt 1))
                {
                    "[$($charSet -join '')]" # It can be any of the character classes
                }
                else # Unless there was only one character class (in this case, put it inline)
                {
                    $charSet
                }
            }

            if ($If -and $Then) { # If they passed us a coniditional, embed it
                if ($Else) {
                    "(?($if)(?:$($then -join ''))|(?:$($else -join '')))"
                } else {
                    "(?($if)(?:$($then -join '')))"
                }
            }

            if ($Greedy) {
                '*'
            }

            if ($Repeat) {
                '+'
            }

            if ($myParams.ContainsKey('Min')) {
                "{$min,$(if($max) { $max})}"
            }

            if ($Optional -and -not $theOc) {
                '?'
            }

            if ($Lazy) {
                '?'
            }

            if ($NotBefore) { # If we've got a negative lookahead
                "(?!$notbefore)" # add it.
            }

            if ($Before) {   # If we've got a positive lookahead
                "(?=$before)"    # add it
            }

            if ($not -and # If we're passed -Not,
                -not ($CharacterClass -or $Pattern)) { # but no -CharacterClass or -Expression
                '(?!)' # emit an empty lookahead (this will always fail)
            }

            if ($EndAnchor) {
                $cclookup[$endanchor]
            }

            if ($between) {
                $firstBetween, $secondBetween = $between
                if (-not $secondBetween) { $secondBetween = $firstBetween }
                ")${escapePattern}${secondBetween}"
                $theOc--
            }

            $hadToBeClosed = $false
            for($n=0; $n -lt $theOc; $n++) {
                ')'; $hadToBeClosed =$true
            }

            if ($hadToBeClosed -and $optional) {
                '?'
            }



        }

        $regex = $regex -join ''

        if ($comment) {
            $regex += " # $($comment -replace '\#', '')
"
        }

        if (-not $Denormalized) {
            $regexLines = $regex -split '(?>\r\n|\n)'
            $commentIndeces = 
                foreach ($l in $regexLines) {                
                    if ($l.Contains('#')) {
                        $commentIndex = $l.IndexOf('#')
                        if ($commentIndex -eq 0) {
                            # Not important for normalization
                        } elseif ($l[$commentIndex - 1] -ne '\') {
                            # As long as the comment is not escaped
                            $commentIndex 
                        }
                    }
                }
            
            foreach ($ci in $commentIndeces) {
                if ($ci -gt $max) {$max  = $ci } 
            }
            
            $regex = 
                @(foreach ($l in $regexLines) {                
                    if ($l.Contains('#')) {
                        $commentIndex = $l.IndexOf('#')
                        if ($commentIndex -eq 0) {
                            # Not important for normalization
                            $l
                        } elseif ($l[$commentIndex - 1] -ne '\') {
                            # As long as the comment is not escaped
                            $l.Substring(0, $commentIndex) + $(
                                ' ' * ($max - $commentIndex)
                            ) + $l.Substring($commentIndex)

                        } else {
                            $l
                        }
                    } else {
                        $l
                    }
                }) -join [Environment]::NewLine
            


        } 

        #endregion Generate RegEx

        $regOut =
            try {
                [psobject]::new([Regex]::new($regex, 'IgnoreCase,IgnorePatternWhitespace', '00:00:05'))
            } catch {
                $_
            }
        if (-not $regOut) { return }
        if ($regOut -is [Management.Automation.ErrorRecord]) {
            $o = [PSCustomObject]@{Pattern=$regex;PSTypeName='Irregular.Regular.Expression'}
            $o | Add-Member ScriptMethod ToString { return $this.Pattern } -PassThru -Force
        } else {
            $regOut.pstypenames.add('Irregular.Regular.Expression')
            $regOut
        }
    }
}