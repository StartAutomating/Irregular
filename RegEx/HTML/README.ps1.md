﻿### HTML Regular Expressions

This directory contains regular expressions that can be used to match and extract HTML.

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