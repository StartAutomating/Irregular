function Show-RegEx
{
    <#
    .Synopsis
        Shows a Regular Expression and it's output.
    .Description
        Displays Regular Expressions, with their match output.
    .Example
        Show-Regex -Pattern ?<Digits> -Match abc123def456
    .Link
        Get-Regex
    .Link
        Use-Regex
    #>
    [OutputType('Irregular.RegEx.Output')]
    param(
    # The regular expression.  If the pattern starts with a saved capture name, it will use the saved pattern.
    [Parameter(Mandatory=$true,Position=0,ValueFromPipelineByPropertyName)]
    [string]
    $Pattern,

    # One or more strings to match.
    [Parameter(Position=1,ValueFromRemainingArguments=$true,ValueFromPipelineByPropertyName)]
    [string[]]
    $Match,

    # If set, will remove the regular expression matches from the text.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Remove,

    # If set, will replace the text with a replacement string.
    # For more information about replacement strings, see:
    # https://docs.microsoft.com/en-us/dotnet/standard/base-types/substitutions-in-regular-expressions
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Replace,

    # If provided, will transform each match with a replacement string.
    # For more information about replacement strings, see:
    # https://docs.microsoft.com/en-us/dotnet/standard/base-types/substitutions-in-regular-expressions
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Transform,

    # The regular expression options, by default, MultiLine, IgnoreCase and IgnorePatternWhitespace
    #|Default Multiline,IgnoreCase,IgnorePatternWhitespace
    #|Multiselect
    [Parameter(Position=3,ValueFromPipelineByPropertyName=$true)]
    [Alias('Options')]
    [Text.RegularExpressions.RegexOptions]
    $Option = 'IgnoreCase, IgnorePatternWhitespace',

    # Indicates that the cmdlet makes matches case-sensitive. By default, matches are not case-sensitive.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]$CaseSensitive,

    # The match timeout.  By default, one second.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Timespan]
    $Timeout = "00:00:01"
    )

    process {
        if ($Pattern -match '^\?\<(?<Name>\w+)\>' -and $script:_RegexLibrary) {
            $Pattern = $script:_RegexLibrary.($matches.Name)
        }

        #region Display RegEx
        if (-not $Match) {
            $regOut =
                try {
                    [psobject]::new([Regex]::new($Pattern, $option, $timeout))
                } catch {
                    $_
                }
            if (-not $regOut) { return }
            if ($regOut -is [Management.Automation.ErrorRecord]) {

                $o = [PSCustomObject]@{Pattern=$Pattern;PSTypeName='Irregular.Regular.Expression'}
                $o | Add-Member ScriptMethod ToString { return $this.Pattern } -PassThru -Force
            } else {
                $regOut.pstypenames.add('Irregular.Regular.Expression')
                $regOut
            }

            return
        }
        #endregion Display RegEx


        #region Use RegEx
        $useRegexSplat = @{} + $PSBoundParameters
        $useRegexSplat.Pattern = $Pattern

        $out = Use-RegEx @useRegexSplat
        [PSCustomObject]@{
            PSTypeName = 'Irregular.RegEx.Output'
            Method =
                if ($Replace -or $Remove) { 'Replace' }
                elseif ($Transform) { 'Transform' }
                else { 'Matches' }
            Input = $useRegexSplat
            Output = $out
            Pattern = $Pattern
        }
        #endregion Use RegEx
    }
}