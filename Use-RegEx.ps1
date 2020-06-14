function Use-RegEx
{
    <#
    .Synopsis
        Uses a saved regular expression.
    .Description
        Uses a saved regular expression, or an expression provided with -Parameter.

        Use-RegEx is normally called with an alias that is the name of a saved RegEx, for example:

        ?<Digits>
    .Link
        Get-RegEx
    .Link
        Write-RegEx
    .Example
        "abc" | Use-RegEx -Pattern '.'
    .Example
        'true', 'false', 'neither' | ?<TrueOrFalse> # ?<TrueOrFalse> is a saved RegEx and alias to Use-RegEx
    .Example
        $txt = "true or false or true or false"
        $m = $txt | ?<TrueOrFalse> -Count 1
        do {
            $m
            $m = $m | ?<TrueOrFalse> -Count 1
        } while ($m) # Looping over each match until non are found.  ?<TrueOrFalse> is an alias to Use-RegEx
    #>
    [CmdletBinding(DefaultParameterSetName='Pattern')]
    [OutputType([Text.RegularExpressions.Match], [string], [PSObject])]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSPossibleIncorrectComparisonWithNull", "", Justification="This is explicitly checking for null (lazy -If would miss 0)")]
    param(
    # One or more strings to match.
    [Parameter(Mandatory=$true,ParameterSetName='Text',ValueFromPipeline,Position=0)]
    [Parameter(ParameterSetName='Pattern',Position=0,ValueFromPipelineByPropertyName)]
    [Alias('InputObject','Text', 'Matches','Input')]
    [string[]]$Match,

    # If set, will return a boolean indicating if the regular expression matched
    [switch]$IsMatch,

    # If set, will measure the number of matches.
    [switch]$Measure,


    # The count of matches to return, or the number of matches split or replaced.
    [Alias('Number')]
    [int]$Count = 0,

    # The starting position of the match
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('EndIndex','StartingAt')]
    [int]$StartAt = 0,

    # If set, will remove the regular expression matches from the text.
    [switch]$Remove,

    # If set, will replace the text with a replacement string.
    # For more information about replacement strings, see:
    # https://docs.microsoft.com/en-us/dotnet/standard/base-types/substitutions-in-regular-expressions
    [string]$Replace,


    # If provided, will replace the match if any of the conditions exist.
    [ValidateScript({
        foreach ($kv in $_.GetEnumerator()) {
            if ($kv.Key -isnot [ScriptBlock]) {
                throw "Keys must be ScriptBlocks"
            }
        }
        return $true
    })]
    [Collections.IDictionary]
    $ReplaceIf,

    # If provided, will each match will be passed to the Replacer ScriptBlock.
    # The values returned from this script block will replace the match.
    [Alias('Replacer','Evaluator')]
    [ScriptBlock]$ReplaceEvaluator,

    # If set, will split the input text according to the expression.
    [switch]$Split,

    # If set, will get the text until the expression.
    [switch]$Until,

    # If -IncludeMatch and -Until are provided, will include the match with the result of -Until.
    # If -IncludeMatch and -Split are provided, will include the matches with the result of -Split.
    # If neither -Split or -Until is provided, this parameter is ignored.
    [Alias('IncludingMatch')]
    [switch]$IncludeMatch,

    # If set, will trim returned strings.
    [switch]$Trim,

    # If set, will extract capture groups into a custom object.
    [switch]$Extract,

    # If provided, will transform each match with a replacement string.
    # For more information about replacement strings, see:
    # https://docs.microsoft.com/en-us/dotnet/standard/base-types/substitutions-in-regular-expressions
    [string]$Transform,

    # If provided, will cast named capture groups to a given type.  This implies -Extract.
    [ValidateScript({
        foreach ($kv in $_.GetEnumerator()) {
            if ($kv.Key -isnot [string]) {
                throw "Keys must be a string"
            }
            if ($kv.Value -isnot [type] -and $kv.Value -isnot [ScriptBlock]) {
                throw "Values must be a type or Script Block"
            }
        }
        return $true
    })]
    [Alias('Cast')]
    [Collections.IDictionary]$Coerce,

    # If provided, will filter the extracted data of a match.
    [ScriptBlock]
    $Where,

    # One or more conditions.  If the condition is true, the value will be returned.
    # If the value is a script block, it will be executed.
    # If the value is a string, it will be treated as a Replacement string (like -Transform).
    [ValidateScript({
        foreach ($kv in $_.GetEnumerator()) {
            if ($kv.Key -isnot [ScriptBlock]) {
                throw "Keys must be ScriptBlocks"
            }
        }
        return $true
    })]
    [Collections.IDictionary]$If,


    # The regular expression options, by default, IgnoreCase and IgnorePatternWhitespace
    [Alias('Options')]
    [Text.RegularExpressions.RegexOptions]
    $Option = 'IgnoreCase, IgnorePatternWhitespace',

    # If set, will go from right to left, instead of left to right.
    [switch]
    $RightToLeft,

    # The match timeout.  By default, five seconds.
    [Timespan]
    $Timeout = "00:00:05",

    # Indicates that the cmdlet makes matches case-sensitive. By default, matches are not case-sensitive.
    [switch]$CaseSensitive,

    # A regular expression.
    [Parameter(ParameterSetName='Pattern',ValueFromPipelineByPropertyName)]
    [Alias('Expression')]
    [string]$Pattern,

    # A pattern generator.  This script will generate a regular expression
    [ScriptBlock]
    $Generator,

    # Named parameters.  These are only valid if the regex is using a Generator script.
    [Alias('Parameters')]
    [Collections.IDictionary]
    $Parameter = @{},

    # A list of arguments.  These are only valid if the regex is using a Generator script.
    [Alias('Arguments','Args')]
    [PSObject[]]$ArgumentList = @()
    )

    dynamicParam {
        # If we didn't have a regex library, create one.
        if (-not $script:_RegexLibrary) { $script:_RegexLibrary = @{} }

        $myInv = $MyInvocation
        # Then, determine what the name of the pattern in the library would be.
        $mySafeName =
            if ('.', '&' -contains $myInv.InvocationName -and
                (
                    $myInv.Line.Substring($MyInvocation.OffsetInLine) -match
                    '^\s{0,}\?\<(?<Name>\w+)\>'
                ) -or (
                    $myInv.Line.Substring($MyInvocation.OffsetInLine) -match
                    '^\s{0,}\$\{\?\<(?<Name>\w+)\>\}'
                )
            )
            {
                $matches.Name
            }
            else
            {
                $myInv.InvocationName -replace '\W', ''
            }

        # Find the regex in the library.
        $regex = $script:_RegexLibrary[$mySafeName]
        $DynamicParameterNames = @()
        if ($regex -isnot [Management.Automation.ExternalScriptInfo]) {
            return
        }
        $generator = $regex
        $generatorMetaData = [Management.Automation.CommandMetaData]$generator
        $DynamicParameters = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
        foreach ($kv in $generatorMetaData.Parameters.GetEnumerator()) {
            $DynamicParameters.Add($kv.Key,
                [Management.Automation.RuntimeDefinedParameter]::new(
                    $kv.Value.Name, $kv.Value.ParameterType, $kv.Value.Attributes
                )
            )
        }
        $DynamicParameterNames = $DynamicParameters.Keys -as [string[]]
        return $DynamicParameters
    }

    begin {
        if ($DynamicParameterNames) {
            foreach ($dynamicParameterName in $DynamicParameterNames) {
                if ($PSBoundParameters.ContainsKey($DynamicParameterName)) {
                    $Parameter[$dynamicParameterName] = $PSBoundParameters[$dynamicParameterName]
                }
            }
        }
        # Now figure out if we'll be extracting later
        $isExtracting =
            $MyInvocation.InvocationName -eq '.' -or
            $Extract -or
            $coerce.Count -or
            $If.Count


        # If -Where or -If was provided, we need to recreate the script blocks for $_ to work.
        if ($Where) { $where = [ScriptBlock]::Create($Where) }

        foreach ($coll in $if, $ReplaceIf, $Coerce) {
            if (-not $coll) { continue }
            foreach ($k in @($coll.Keys)) {
                $v = $coll[$k]
                if ($v -is [ScriptBlock]) { $v = [ScriptBlock]::Create($v) }
                $coll.Remove($k)
                if ($k -is [ScriptBlock]) {
                    $k = [ScriptBlock]::Create($k)
                }
                $coll[$k] = $v
            }
        }


        #region [ScriptBlock]$ExtractMatch
        $extractMatch = { process {
            $m = $_
            $xm = [Ordered]@{}
            foreach ($g in $m.Groups) {
                if ($g.Name -as [int] -ge 1) { continue }
                $gcv =
                    foreach ($gc in $g.Captures) {
                        $gc.Value
                    }
                if ($Coerce -and $Coerce.$($g.Name) -is [type]) {
                    $xm[$g.Name] = foreach ($v in $gcv) { $v -as $Coerce.$($g.Name) }
                } elseif ($Coerce -and $Coerce.$($g.Name) -is [ScriptBlock]) {
                    $xm[$g.Name] = foreach ($v in $gcv) { $_ = $v; & $Coerce.$($g.Name) $v }
                } else {
                    $xm[$g.Name] = $gcv # set it in $matches
                }
            }
            $xm.Match = $m
            $xm.PSTypeName = 'Irregular.Match.Extract'
            [PSCustomObject]$xm
        } }
        #endregion [ScriptBlock]$ExtractMatch

        #region [ScriptBlock]$FilterMatches
        $FilterMatches =
            { process {
                if ($_ -is [Boolean] -or $_ -is [string]) { return $_ }
                $currentMatch = $_
                $MatchMetaData = [Ordered]@{
                    StartIndex = $_.Index
                    EndIndex = $_.Index + $_.Length
                    Input = $_.Result('$_')
                }
                if ($isExtracting -or $Where) {
                    $xm = $currentMatch | & $extractMatch
                }
                if ($where) {
                    $this = $_ = $xm
                    $IsThere = . $where $in
                    if (-not $IsThere) { return }
                    $_ = $currentMatch
                }

                if ($transform) {
                    return . $decorateString $currentMatch.Result($transform) $matchMetaData
                }
                if ($if.Count) {
                    $in = $_ = $xm
                    foreach ($ifCondition in $if.GetEnumerator()) {
                        $ifResult = & $ifCondition.Key $in
                        if ($ifResult) {
                            if ($ifCondition.Value -is [ScriptBlock]) {
                                $_ = $xm
                                . $ifCondition.Value $in
                            } elseif ($ifCondition.Value -is [string]) {
                                . $decorateString $currentMatch.Result($ifCondition.Value) $matchMetaData
                            } else {
                                $ifCondition.Value
                            }
                        }
                    }
                    return
                }
                if ($isextracting) {
                    return $xm
                }
                if ($currentMatch.psobject.properties['EndIndex'] -isnot [PSScriptProperty]) { # add on two script properties we might want:
                    $currentMatch.psobject.properties.Remove('EndIndex') # EndIndex
                    $currentMatch.psobject.properties.add([PSScriptProperty]::new('EndIndex', { $this.Index + $this.Length }))
                }
                if ($currentMatch.psobject.properties['Input'] -isnot [PSScriptProperty]) {
                    $currentMatch.psobject.properties.Remove('Input')
                    $currentMatch.psobject.properties.add([PSScriptProperty]::new('Input', { $this.Result('$_') })) # and Input.
                }

                if ($inputObject -and $inputObject -ne $currentMatch.Input) {
                    $currentMatch.psobject.Properties.Remove('InputObject')
                    $currentMatch.psobject.properties.add([PSNoteProperty]::new('InputObject', $inputObject))
                } else {
                    $currentMatch.psobject.Properties.Remove('InputObject')
                    $currentMatch.psobject.properties.add([PSAliasProperty]::new('InputObject', 'Input'))
                }

                return $currentMatch
            } }
        #endregion [ScriptBlock]$FilterMatches

        #region [ScriptBlock]$DecorateString
        $DecorateString = {
            param(
            [string]$string,
            [Collections.IDictionary]$property = @{})
            if ($trim) {
                $string = $string.Trim()
            }
            $psString = [PSObject]::new($string)
            foreach ($kv in $property.GetEnumerator()) {
                $psString.psobject.properties.add([PSNoteProperty]::new($kv.Key, $kv.Value))
            }
            $psString
        }
        #endregion [ScriptBlock]$DecorateString
    }

    process {
        #region Prepare Input
        $in = $inputObject = $_
        if ($_.Input) { # First we want to see if the piped in object had an input property.
            $match = $_.Input # If it did, we're using it to cheat in the value to -Match.
        }

        if ($in -is [IO.FileInfo]) { # If the input was a file,
            $match = [IO.File]::ReadAllText($in.FullName) # we want to match the file contents
        }

        if ($in -is [Management.Automation.ExternalScriptInfo]) { # If we were passed an external script
            $match = "{$($in.ScriptContents)}" # we want to match it's contents.
        }

        if ($in -is [Management.Automation.FunctionInfo]) { # If we're passed a function,
            $match = "function $($in.Name) {$($in.ScriptBlock)}" # we want to match the definition.
        }

        if ($in -is [ScriptBlock]) {
            $match = "{$in}"
        }

        if ($_ -is [Text.RegularExpressions.Match] -and -not $StartAt) { # If the input was a [Match] and we don't have a start
            if (-not $_.psobject.properties['EndIndex']) { # add on two script properties we might want:
                $_.psobject.properties.add( # EndIndex
                    [PSScriptProperty]::new('EndIndex', { $this.Match.Index + $this.Match.Length })
                )
            }
            if (-not $_.psobject.properties['Input']) {
                $_.psobject.properties.add( # and Input.
                    [PSScriptProperty]::new('Input', { $this.Match.Result('$_') })
                )
            }
        }
        #endregion Prepare Input

        #region Initialize Regular Expression
        # If the saved RegEx is a generator
        if ($regex -is [Management.Automation.ExternalScriptInfo] -or
            $regex -is [ScriptBlock]) {
            if ($generator -and $mySafeName -and $mySafeName -ne ($MyInvocation.MyCommand.Name -replace '\W', '')) {
                Write-Error "Will not override ?<$mySafeName>" -ErrorId RegEx.No.Override -Category InvalidOperation
                return
            }

            $Generator =
                if ($regex -is [Management.Automation.ExternalScriptInfo]) {
                    $regex.ScriptBlock
                } else {
                    $regex
                }
        }

        if ($Generator) { # (or one was provided)
            $regex = & $Generator @argumentList @Parameter # run the generator.
            if ($regex -and $mySafeNAme -and -not "$regex".StartsWith("(?<$mySafeName") -and -not $mySafeName -eq 'UseRegEx') {
                $regex = "(?<$mySafeName>$($regex;[Environment]::NewLine;))"
            }
        }

        if ($Pattern) { # If we've been provided a pattern
            # and it would overriding something
            if ($mySafeName -and $mySafeName -ne ($MyInvocation.MyCommand.Name -replace '\W', '')) {
                Write-Error "Will not override ?<$mySafeName>" -ErrorId RegEx.No.Override -Category InvalidOperation
                return
            }

            if ($pattern -match '^\?\<(?<Name>\w+)\>' -and $script:_RegexLibrary) {
                $pattern = $script:_RegexLibrary.($matches.Name)
            }

            # If we didn't have to warn them, we've propably piped in a [Regex] or the output of Write-Regex.
            $regex = [Regex]::new($Pattern, 'IgnoreCase,IgnorePatternWhitespace')
        }

        if (-not $regex) { return } # If for any reason our regex is invalid, return.

        if ($RightToLeft) { # If we're going RightToLeft
            $Option = $Option -bor 'RightToLeft' # adjust the Regex options
            if ($StartAt -and $_.EndIndex -eq $startAt -and $_.Index -ne $null) { # and adjust the start if needed.
                $startAt = $_.Index
            }
            if (-not $startAt -and $_.EndIndex) { return }
        }

        if ($CaseSensitive) { # If we're using CaseSensitive,
            $option = $option -bxor 'IgnoreCase' # adjust the RegEx options.
        }

        # Then recreate the regex with the new options and timeout
        $regex = [Regex]::new("$regex", $Option, $Timeout)


        if (-not $regex) { return } # If for any reason our regex is invalid, return.
        #endregion Initialize Regular Expression

        if (-not $Match) { # If we haven't been given any text to match
            $regex.pstypenames.add('Irregular.Regular.Expression') # decorate the Regex for the formatter.
            return $regex # and return it.  This will let "true" -match (?<TrueOrFalse>) be valid PowerShell.
        }
        $OriginalStartAt = $StartAt
        foreach ($m in $Match) { # Walk over each text we're supposed to match
            $$, $methodArgs = $null, $null
            if ($RightToLeft -and -not $OriginalStartAt) {
                $startAt = $m.Length
            }
            if ($until) { # If we're matching until that point
                $matches = $regex.Match($m, $StartAt) # find the first match after StartAt.
                if (-not $matches.Success) { continue } # If the match failed, continue.
                if ($measure) {
                    if ($RightToLeft) {
                        $startAt - ($matches.Index - $matches.Length)
                    } else {
                        $matches.Index - $startAt
                    }
                    continue
                }
                $ei = # Determine the EndIndex
                    if ($IncludeMatch) { # ( if we're including the match
                        $matches.Index + $matches.Length # its the end of the match,
                    } else {
                        $matches.Index # otherwise, it's the start of the match).
                    }

                if ($startAt, ($ei - $startAt) -lt 0) { continue }

                # Then get the substring and decorate it with the following properties:
                . $DecorateString ($m.Substring($startAt, $ei - $startAt)) ([Ordered]@{
                    StartIndex = $startAt # | StartIndex| The Start Index |
                    EndIndex = $ei # | EndIndex| The End Index |
                    Input = $matches.Result('$_') # | Input | The Match Input String |
                })
            }
            elseif ($Split) {
                # If we're splitting, we get the matches.
                # (this lets us -IncludeMatch and sidestep a .NET bug when splitting -RightToLeft)
                $matches = @($regex.Matches($M,$StartAt) | & $filterMatches)
                $upTo = if ($Count) { $count } else {$matches.Count}
                $commonInfo = [Ordered]@{Input=$m;InputObject=$in}
                if ($RightToLeft) {
                    $s = if ($startAt -ne $m.Length) { $startAt } else { $m.Length }
                    for ($mc=0;$mc -lt $upTo;$mc++) {
                        $me = $matches[$mc].Index + $matches[$mc].Length
                        if ($me -lt $s) {
                            . $decorateString $m.Substring($me, $s - $me)
                        }
                        if ($IncludeMatch) {
                            . $decorateString $matches[$mc] ([Ordered]@{
                                StartIndex = $matches[$mc].Index
                                EndIndex = $matches[$mc].Index + $matches[$mc].Length
                            } + $commonInfo)
                        }
                        $s = $matches[$mc].Index
                    }

                    if ($s -gt 0) {
                        . $decorateString $m.Substring(0, $s)
                    }
                } else {
                    $s = $startAt
                    for ($mc=0;$mc -lt $upTo;$mc++) {
                        if ($matches[$mc].Index - $s) {
                            . $decorateString $m.Substring($s, $matches[$mc].Index - $s)
                        }
                        if ($IncludeMatch) {
                            . $decorateString $matches[$mc] ([Ordered]@{
                                StartIndex = $matches[$mc].Index
                                EndIndex = $matches[$mc].Index + $matches[$mc].Length
                            } + $commonInfo)
                        }

                        $s = $matches[$mc].Index + $matches[$mc].Length
                    }

                    if ($s -ne $m.Length) {
                        . $decorateString $m.Substring($s)
                    }
                }
            }
            elseif ($Remove -or $Replace -or $ReplaceEvaluator -or $ReplaceIf.Count) {
                $$ = 'Replace'
                $methodArgs = @(
                    $M
                    if ($remove) { '' }
                    elseif ($Replace) { $Replace }
                    elseif ($ReplaceEvaluator) { $ReplaceEvaluator }
                    elseif ($ReplaceIf) {
                        {
                            $tm = $($args[0])
                            $xm = $($tm | & $filterMatches | & $extractMatch )
                            foreach ($kv in $ReplaceIf.GetEnumerator()) {
                                $_ = $xm
                                $kvR = . $kv.Key $xm
                                if ($kvR) {
                                    if ($kv.Value -is [ScriptBlock]) {
                                        return "$(. $kv.Value $xm)"
                                    }

                                    return $tm.Result("$($kv.Value)")
                                }
                            }
                            return "$tm"
                        }
                    }
                    if ($Count) { $Count } else { [int]::MaxValue }
                    $StartAt
                )
            }
            elseif ($IsMatch) {
                $$= 'IsMatch'
                $methodArgs = @($M;$StartAt)
            }
            elseif ($Count) {
                $$ =0
                $methodArgs = @($M;$StartAt)
                $matches = $regex.Match.Invoke($methodArgs)
                if ($Measure) {
                    $t = 0
                }
                while ($matches.Success -and $$ -lt $Count) {
                    if (-not $measure) {
                        $matches | & $filterMatches
                    } else {
                        $t++
                    }
                    $$++
                    $matches = $matches.NextMatch()
                }
                if ($measure) { $t }
            }
            else {
                $$ = 'Matches'
                $methodArgs = @($M;$StartAt)
            }
            if ($regex.$$ -and $methodArgs) {
                if ($measure) {
                    @($regex.$$.Invoke($methodArgs)).Length
                } else {
                    & {
                        try {
                            $regex.$$.Invoke($methodArgs)
                        } catch {
                            $PSCmdlet.WriteError([Management.Automation.ErrorRecord]::new($_.Exception, 'Regular.Expression.Error', 'NotSpecified', $inputObject))
                        }
                    } | & $filterMatches
                }
            }
        }
    }
}