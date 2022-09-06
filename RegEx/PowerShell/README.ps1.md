This directory contains regular expressions to help parse PowerShell.

It should be noted that these regular expressions _are not_ a perfect parser of PowerShell, nor are they designed to be.

They are designed to work in _most_ scenarios and to offer an alternative way to information about a PowerShell script without loading it into memory as a ```[ScriptBlock]```.

~~~PipeScript{
    Import-Module ../../Irregular.psd1 -Global
    $directoryName = $pwd | Split-Path -Leaf     
    [PSCustomObject]@{
        Table = Get-Regex -Name "${directoryName}_*" |
            Sort-Object Name |
            Select @{
                Name='Name'
                Expression={"[?<$($_.Name)>]($($_.Path | Split-Path -Leaf))"}
            }, Description, IsGenerator
    }}
~~~
