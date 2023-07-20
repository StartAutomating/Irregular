function Compress-Regex
{
    <#
    .SYNOPSIS
        Compresses Regular Expressions
    .DESCRIPTION
        Compresses a Regular Expression, removing all whitespace and comments.

        This will make a regular expression much more difficult to read, and a bit shorter.
    .EXAMPLE
        New-Regex -Description "This is a description of a regex nobody will care about" |
            New-Regex -Name Width @(
                ?<Decimals>
            ) |
            New-Regex -Name Height @(
                ?<Decimals>
            ) |  Compress-Regex
    #>
    param(
    # The regular expression to compress.
    [Parameter(Mandatory,
        ValueFromPipeline,
        ValueFromPipelineByPropertyName,
        Position=0)]
    [Alias('RegularExpression','Pattern','Expression')]
    [Regex]
    $Regex,

    # The Match Timeout.
    # By default, this value will be carried over from the -RegEx.
    [timespan]
    $MatchTimeout = '00:00:01'
    )

    process {
        # Create a new regex from the old:
        [Regex]::new(
            (
                # To compress the regex, split it by newlines
                "$Regex" -split '(?>\r\n|\n)' -replace 
                    # and strip comments                    
                    '(?<!\\)#.+$' -join ([Environment]::NewLine) -replace 
                    # and strip whitespace.
                    '[\s\n\r]'
            ),
            # We'll keep the regex options should remain the same, for now.
            $Regex.Options,
            $(
                # If we provided a -MatchTimeout
                if ($PSBoundParameters["MatchTimeout"]) {
                    $MatchTimeout # use that
                } elseif ($Regex.MatchTimeout.TotalSeconds -gt 0) {
                    $Regex.MatchTimeout # otherwise, carry the timeout from the [Regex]
                } else {
                    $MatchTimeout # and if it didn't have one, use the default for -MatchTimeout.
                }
            )
        )
    }
}
