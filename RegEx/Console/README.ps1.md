This directory contains regular expressions for advanced console features, such as [ANSI escape sequences](https://en.wikipedia.org/wiki/ANSI_escape_code).

Note:  Using these regular expressions in the terminal may result in awkward output.  (the .Match will contain an escape sequence, which will make the next output attempt to use this escape sequence)

~~~PipeScript{
    Import-Module ../../Irregular.psd1 -Global
    $directoryName = $pwd | Split-Path -Leaf     
    [PSCustomObject]@{
        Table = Get-Regex -Name "${directoryName}_*" |
            Sort-Object Name |
            .Name {
                "[?<$($_.Name)>]($($_.Path | Split-Path -Leaf))"
            } .Description .Source {
                if ($_.IsGenerator) { 
                    "[generator]($($_.Path | Split-Path -Leaf))"
                }
                else {
                    $sourcePath = $_.Path -replace '\.txt$', '.source.ps1'
                    if (Test-Path $sourcePath) {                        
                        "[source]($($sourcePath | Split-Path -Leaf))"
                    } else {
                        ''
                    }
                }
            }            
    }}
~~~