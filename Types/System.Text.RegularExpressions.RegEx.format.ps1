Write-FormatView -TypeName System.Text.RegularExpressions.RegEx -Action {
    $pattern = "$($_.ToString())"
    @(for ($i = 0; $i -lt $pattern.Length; $i++) {
        if ($pattern[$i -1] -eq '\') {
            if ($pattern[$i -2] -ne '\' -or ($pattern[$i -2] -eq '\' -and $pattern[$i -3] -eq '\')) {
                . $encodeOutput $pattern[$i];
                continue
            }
        }
        if ($i -and $pattern[$i] -eq '?' -and $pattern[$i + 1] -eq '<' -and $pattern[$i + 2] -match '[\w\-]') {
            # Group name
            . $SetOutputStyle -ForegroundColor Success # Irregular.Regex.GroupName
            $nameEnd = $pattern.IndexOf('>', $i)
            . $EncodeOutput $pattern.Substring($i, 2)
            . $SetOutputStyle -Underline
            . $EncodeOutput $pattern.Substring($i + 2, $nameEnd - ($i + 2))
            . $ClearOutputStyle -Underline
            $i = $nameEnd
            . $EncodeOutput '>'
            . $ClearOutputStyle -ForegroundColor
            continue
        }

        if ('(',')','[',']' -contains $pattern[$i]) {
            # Grouping paranthesis
            . $SetOutputStyle -ForegroundColor Warning <#Irregular.Regex.Group#> -Bold
            . $encodeOutput $pattern[$i]
            . $ClearOutputStyle
            continue
        }

        if ('|','?','<','>','!' -contains $pattern[$i]) {
            . $SetOutputStyle -ForegroundColor Verbose <#Irregular.Regex.Operator#> -Bold
            . $encodeOutput $pattern[$i]
            . $ClearOutputStyle
            continue
        }

        if ($pattern[$i] -eq '#') {
            . $SetOutputStyle -ForegroundColor Success # Irregular.Regex.Comment
            $lineEnd = $pattern.IndexOfAny([Environment]::NewLine.ToCharArray(), $i)
            if (($lineEnd - $i) -gt 0) {
                . $EncodeOutput $pattern.Substring($i, $lineEnd -$i)
                $i = $lineEnd - 1

            } else {
                . $EncodeOutput $pattern.Substring($i)
                $i = $pattern.Length
            }
            . $ClearOutputStyle
            continue
        }


        . $encodeOutput $pattern[$i]
    }) -join ''

}

Write-FormatView -TypeName System.Text.RegularExpressions.RegEx -Property GroupNames, Pattern, Options, MatchTimeout -AsList

Write-FormatView -TypeName System.Text.RegularExpressions.RegEx -Property Pattern, GroupNames -Wrap
