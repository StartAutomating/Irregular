﻿#requires -Module Pester, Irregular
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingCmdletAliases", "", Justification="Irregular Uses Smart Aliases")]
param()


describe Get-Regex {
    it "Lets you keep a library of Regular Expressions" {
        Get-RegEx
    }
    it "Lets you get a particular item by name" {
        Get-RegEx -Name TrueOrFalse
    }
    it 'Can get RegExs from a -FilePath' {
        Get-Regex -FilePath (Get-Command Get-Regex | Get-Module | Split-Path)
    }
    it 'Can get Regexes -FromModule ' {
        Get-Regex -FromModule Irregular
    }
    it 'Can get a Regex -As a String' {
        Get-Regex -Name Digits -As String | should -Be '\d+'
    }
    it 'Can get a RegEx -As a File' {
        Get-Regex -Name Digits -As File |
            Select-Object -ExpandProperty Name |
            should -Be Digits.regex.txt
    }
    it 'Can get a RegEx -As a Pattern' {
        Get-Regex -Name Digits -As Pattern | should -BeLike '*\d+*'
    }
    it 'Can get a RegEx -As a Hashtable' {
        Get-RegEx -Name Digits -As Hashtable | should -BeLike  '@{*'
    }
    it 'Can get a RegEx -As a Variable' {
        Get-RegEx -Name Digits -As Variable | should -BeLike '$digits*=*\d+*'
    }
    it 'Can get a RegEx -As an Alias' {
        Get-RegEx -Name Digits -As Alias | should -Be 'Set-Alias ?<Digits> Use-RegEx'
    }
    it 'Can get a RegEx -As a Lambda' {
        $lambda = Get-RegEx -Name Digits -as Lambda
        $lambda | should -BeLike '*RegexLibrary*'
        $lambda | should -BeLike '*Digits*'
        $lambda | should -BeLike '*UseRegex*=*'
        $lambda | should -BeLike '*${?<Digits>}*=*$UseRegex'
    }
}


describe Import-Regex {
    it 'Imports Regular Expressions into the library' {
        Import-RegEx
    }
    it 'Can import -FromModule' {
        Import-RegEx -FromModule Irregular -PassThru
    }
    it 'Can Import from a -FilePath' {
        Import-RegEx -FilePath (Get-Module Irregular | Split-path) -PassThru
    }
    it 'Can import a -Pattern directly' {
        Import-RegEx -Pattern "(?<AnySymbol>\p{S})"
        (?<AnySymbol>).GetType() | should -Be ([Regex])
    }
}

describe Show-Regex {
        it 'Is an interactive tool to preview simple Regex operations' {
            $o = Show-RegEx -Pattern '?<Digits>' -Match abc123def456
            $o.Output.Count | should -Be 2
        }
        it 'Can -Remove content' {
            $o = Show-RegEx -Pattern '?<Digits>' -Match abc123def456 -Remove
            $o.Output | should -Be abcdef
        }
        it 'Can -Replace content' {
            $o = Show-RegEx -Pattern '?<Digits>' -Match abc123def456 -Remove
            $o.Output | should -Be abcdef
        }
        it 'Will return the Regex is no other parameters than Pattern are passed' {
            $o = Show-RegEx -Pattern '?<Digits>'
            "$o" |should -BeLike *\d+*
        }
        it 'Will show that invalid patterns are invalid' {
            $o = Show-RegEx -Pattern '('
            $o.IsValid | should -Be $false
        }
    }

describe Use-Regex {
    it 'Is normally used with an alias of a named expression (e.g. ?<Digits>)' {
        (?<Digits>).GetType() | should -Be ([Regex])
    }
    it 'Lets you find all matches' {
        ?<Digits> -Match "123abc456" |
            Measure-Object |
            Select-Object -ExpandProperty Count|
            should -Be 2
    }
    it 'Lets you find a single match' {
        ?<Digits> -Match '123abc456' -Count 1 |
            Measure-Object |
            Select-Object -ExpandProperty Count|
            should -Be 1
    }
    it 'Lets you piped in multiple inputs' {
        "123abc456", "def789" | ?<Digits> |
            Measure-Object |
            Select-Object -ExpandProperty Count |
            should -Be 3
    }
    it 'Can search -RightToLeft' {
        "123abc456" |
            ?<Digits> -RightToLeft -Count 1 |
            Select-Object -ExpandProperty Value |
            should -Be 456
    }
    it 'Can -Extract results' {
        @('123abc456' |
            ?<Digits> -Extract |
            Select-Object -ExpandProperty Digits) | should match '\d+'
    }
    it 'Will assume -Extract if called with a .' {
        '123abc456'  | . ?<Digits> | Select-Object -ExpandProperty Digits  | should match \d+
    }
    it 'Can -Coerce (or -Cast) results to a type' {
        '123abc456' |
            ?<Digits> -Coerce @{Digits=[int]} -Count 1 |
            Select-Object -ExpandProperty Digits |
            should -Be 123
    }
    it 'Can -Coerce results with a [ScriptBlock]' {
        '123abc456' |
            ?<Digits> -Coerce @{
                Digits={($_ -as [int]) * 2}
            } -Count 1 |
            Select-Object -ExpandProperty Digits |
            should -Be 246
    }
    it 'Can filter results with -Where' {
        @('123abc456' |
            ?<Digits> -Where {$_.Digits %2 } |
            should -Be '123')
    }
    it 'Can -Remove matches' {
        '123abc456' |?<Digits> -Remove | should -Be abc
    }
    it 'Can -Replace matches' {
        '123abc456' |?<Digits> -Replace ' $1 ' | should -Be ' 123 abc 456 '
    }
    it 'Can -ReplaceIf a conidition is met' {
        '123abc456' |
            ?<Digits> -ReplaceIf @{ { $_.Digits % 2 } = '$1 (is odd) '} |
            should -Be '123 (is odd) abc456'
    }
    it 'Can use a -Replacer [ScriptBlock]' {
        '123abc456' |
            ?<Digits> -ReplaceEvaluator { '_' } |
            should -Be _abc_
    }
    it 'Can -Replace a -Count' {
        '123abc456' | ?<Digits> -Remove -Count 1 | should -Be abc456
    }

    it 'Can -Transform matches into something else' {
        @('123abc456' | ?<Digits> -Transform '-$1' ) -join ' ' | should -Be '-123 -456'
    }
    it 'Can transform a match -If a condition is met' {
        '123abc456' |
            ?<Digits> -If @{{$_.Digits %2 } = '$1 is odd' } |
            should -Be '123 is odd'
    }

    it 'Can run a script -If a condition is met' {
        '123abc456' |
            ?<Digits> -If @{{$_.Digits %2 } = {"$([int]$_.Digits * 2) is even" }} |
            should -Be '246 is even'
    }

    it 'Can return an arbitrary value -If a condition is met' {
        $randomNumber = [Random]::new().Next()
        '123' | ?<Digits> -If @{{$_} = $randomNumber } | should -Be $randomNumber
    }

    it 'Will -Coerce before -If' {
        '123abc456' |?<Digits> -Coerce @{Digits=[int]} -If @{{$_.Digits %2 } = {"$($_.Digits * 2 ) is even" }} | should -Be '246 is even'
    }

    context '-Split' {
        it 'Will -Split a string' {
            "key:value" |?<Colon> -Split | Select-Object -First 1 | should -Be key
        }
        it 'Will -Split a string -RightToLeft' {
            'key: value' | ?<Colon> -Split -Trim -RightToLeft | Select-Object -First 1 | should -Be value
        }

        it 'Will -Split -StartAt at point' {
            'prefix: key: value' |
                ?<Colon> -Split -StartAt 'prefix:'.Length -Trim |
                Select-Object -First 1 |
                should -Be key
        }

        it 'Can -IncludeMatch with a -Split' {
            $k,$s, $v = "key:value" |?<Colon> -Split -IncludeMatch
            $s | should -Be ':'
            $k,$s, $v = "key:value" |?<Colon> -Split -IncludeMatch -RightToLeft
            $s | should -Be ':'
        }

        it 'Will -Split -Count number of times' {
             'key: value: with a colon' |
                ?<Colon> -Split -Count 1 -Trim |
                Select-Object -First 1 -Skip 1 |
                should -Be 'value: with a colon'
        }

        it 'Will -Split -Count items from -RightToLeft' {
            'lkey: value:value:rkey' |
                ?<Colon> -Split -Count 1 -RightToLeft -Trim |
                Select-Object -First 1 |
                should -Be 'rkey'
        }


    }

    context '-Until' {
        it 'Can get content -Until a point' {
        "How much wood would a woodchuck chuck if a woodchuck could chuck wood?" |
            ?<Punctuation> -Until |
            should -Be "How much wood would a woodchuck chuck if a woodchuck could chuck wood"
        }
        it 'Can -IncludeMatch with -Until' {
            "How much wood would a woodchuck chuck if a woodchuck could chuck wood?" |
                ?<Punctuation> -Until -IncludeMatch |
                should -Be "How much wood would a woodchuck chuck if a woodchuck could chuck wood?"
        }
        it 'Can -Measure the distance -Until a match' {
            'key:value' |?<Colon> -Until -Measure | should -Be 3
            'key:value' |?<Colon> -Until -Measure -RightToLeft | should -Be 7
        }
    }





    it 'Can make any RegEx -CaseSensitive' {
        Use-RegEx -Pattern 'param' -Match 'Param' -IsMatch -CaseSensitive | should -Be $false
    }

    it 'Can -Measure the number of matches' {
        Use-RegEx -Pattern '(?>\r\n|\n)' -Measure -Match ([Environment]::NewLine * 6) |
            should -Be 6

        Use-RegEx -Pattern '(?>\r\n|\n)' -Measure -Match ([Environment]::NewLine * 8) -Count 4 |
            should -Be 4
    }

    it 'Can seek from one match to the next' {
        @($txt = "true or false or true or false"
        $m = $txt | ?<TrueOrFalse> -Count 1
        do {
            $m
            $m = $m | ?<TrueOrFalse> -Count 1 -Scan
        } while ($m)) -join ' ' | # Looping over each match until non are found.  ?<TrueOrFalse> is an alias to Use-RegEx
            should -Be 'true false true false'
    }

    it 'Can seek from one match to the next (from -RightToLeft)' {
        @($txt = "true or false or true or false"
        $m = $txt | ?<TrueOrFalse> -Count 1 -RightToLeft
        do {
            $m
            $m = $m | ?<TrueOrFalse> -Count 1 -RightToLeft -Scan
        } while ($m)) -join ' ' | # Looping over each match until non are found.  ?<TrueOrFalse> is an alias to Use-RegEx
            should -Be 'false true false true'
    }

    context 'Special Piping Behavior' {
        it 'Will match the contents if piped in a file' {
            (Get-Command New-RegEx |
                Select-Object -ExpandProperty ScriptBlock |
                Select-Object -ExpandProperty File) -as [IO.FileInfo] |
            ?<PowerShell_HelpField> |
                Select-Object -ExpandProperty InputObject |
                Select-Object -ExpandProperty Name |
                should -Be New-RegEx.ps1
        }

        it 'Will match the script contents if passed an external script' {
            Get-Command ((Get-Command New-RegEx |
                Select-Object -ExpandProperty ScriptBlock |
                Select-Object -ExpandProperty File)) |
                ?<PowerShell_HelpField> |
                Select-Object -ExpandProperty InputObject |
                Select-Object -ExpandProperty Name |
                should -Be New-RegEx.ps1
        }

        it 'Will match the definition if passed a function' {
            Get-Command New-RegEx |
                ?<PowerShell_HelpField> |
                Select-Object -ExpandProperty InputObject |
                Select-Object -ExpandProperty Name |
                should -Be New-RegEx
        }
    }

    context Generators {
        it 'Can use a .regex.ps1 to generate a Pattern' {
            "{'hello world'}" | ?<BalancedCode> |
                Select-Object -ExpandProperty Value |
                should -Be "{'hello world'}"
        }

        it 'Can pass named -Parameter[s] to a generator' {
            "{'hello world'}" | ?<BalancedCode> -ExpressionParameter @{Open='{'} |
                Select-Object -ExpandProperty Value |
                should -Be "{'hello world'}"
        }

        it 'Can pass -Arguments to a generator' {
            "['hello world']" | ?<BalancedCode> -ExpressionArgumentList '['  |
                Select-Object -ExpandProperty Value |
                should -Be "['hello world']"
        }

        it 'Can use a dynamic generator' {
            $rx = Use-RegEx -Generator {param($t) "$t"} -ExpressionParameter @{t='hi'}
            "$rx"| should -BeLike *hi*
        }

    }


    context 'Fault Tolerance' {
        it 'Will complain if -If is passed keys that are not script blocks' {
            { '123' |?<Digits> -If @{a='b'}} | should throw
        }
        it 'Will complain if -ReplaceIf is passed keys that are not script blocks' {
            { '123' |?<Digits> -ReplaceIf @{a='b'}} | should throw
        }
        it 'Will complain if -Coerce is passed non-strings as keys' {
            { '123' |?<Digits> -Coerce @{{'Digits'} = [int]}} | should throw
        }
        it 'Will complain if -Coerce is passed non-types as values ' {
            { '123' |?<Digits> -Coerce @{'Digits' = "alksldj"} } | should throw
        }
        it 'Will complain when a Named expression is passed a pattern' {
            { ?<Digits> -Pattern 'blah' -ErrorAction Stop } | should throw
        }
    }
}


describe New-RegEx {
    it "Helps you write -CharacterClasses" {
        New-RegEx -CharacterClass LowerCaseLetter |
            Select-Object -ExpandProperty Pattern |
            should -Be '\p{Ll}'
    }

    it "Helps you write -CharacterClasses and -ExcludeCharacterClass" {
        $r = New-RegEx -CharacterClass Punctuation -ExcludeCharacterClass PunctuationOpen, PunctuationClose
        $r.Match("(a)").Success | Should -Be $false
        $r.Match(".").Success | Should -Be $true
    }

    it "Lets you look for repeated content" {
        New-RegEx -CharacterClass Digit -Repeat |
            Select-Object -ExpandProperty Pattern |
            should -Be '\d+'
    }



    it "Simplifies lookahead with -Before (aka -LookAhead)" {
        New-RegEx -Expression 'q' -LookAhead u | # Matches a q that is followed by a u
            Select-Object -ExpandProperty Pattern |
            should -Be 'q(?=u)'
    }

    it 'Simplifies lookbehind with -After (aka -LookBehind)' {
        New-RegEx -Expression u -LookBehind q | # Matches a u that is preceeded by a q
            Select-Object -ExpandProperty Pattern |
            should -Be '(?<=q)u'
    }

    it 'Simplifies negative lookahead with -NotBefore' {
        New-RegEx -Expression q -NotBefore u | # Matches a q that isn't followed by a u
            Select-Object -ExpandProperty Pattern |
            should -Be 'q(?!u)'
    }


    it "Simplifies negative lookbehind with -NotAfter (aka -NegativeLookBehind)" {
        New-RegEx -Expression '"' -NegativeLookBehind '\\' |
            Select-Object -ExpandProperty Pattern |
            should -Be '(?<!\\)"'
    }
    it "Can pipe to itself to compound expressions" {
        New-RegEx -Pattern '"' |
            New-RegEx -CharacterClass Any -Repeat -Lazy -Before (
                New-RegEx -Pattern '"' -NotAfter '\\|`'
            ) |
            New-RegEx -Pattern '"' |
            Select-Object -ExpandProperty Pattern |
            should -Be '".+?(?=(?<!\\|`)")"'
    }

    it 'Can combine more than on -CharacterClass' {
        New-RegEx -CharacterClass Digit, Word |
            Select-Object -ExpandProperty Pattern |
            should -Be '[\d\w]'
    }

    it 'Can negate a -CharacterClass' {
        New-RegEx -CharacterClass Digit, Word -Not |
            Select-Object -ExpandProperty Pattern |
            should -Be '[^\d\w]'
    }

    it 'Can handle -LiteralCharacters' {
        ?<> -Name UserName -LiteralCharacter .- -CharacterClass Word -Repeat |
            ?<> (?<> '\@' -NoCapture) |
        ?<> -Name Domain -LiteralCharacter .- -CharacterClass Word -Repeat
    }

    it 'Can negate a -LiteralCharacter' {
        New-RegEx -LiteralCharacter '.' -Not | Should -Be '[^\.]'
    }

    it 'Can use a -StartAnchor or -EndAnchor' {
        New-RegEx -CharacterClass Whitespace -Min 0 -StartAnchor LineStart -EndAnchor LineEnd |
            Select-Object -ExpandProperty Pattern |
            should -Be '^\s{0,}$'
    }

    it 'Can check for  -Min and -Max occurances' {
        New-RegEx -CharacterClass Whitespace -Min 0 -Max 4 |
            Select-Object -ExpandProperty Pattern |
            should -Be '\s{0,4}'
    }

    it 'Can leave a comment' {
        New-RegEx -CharacterClass Whitespace -Comment "Whitespace" |
            Select-Object -ExpandProperty Pattern |
            should -BeLike "\s # Whitespace*"
    }

    it 'Can write a description' {
        New-RegEx -CharacterClass Whitespace -Description "Whitespace" |
            Select-Object -ExpandProperty Pattern |
            should -Be "# Whitespace$([Environment]::NewLine)\s"
    }

    it 'Can name a capture' {
        New-RegEx -Name Digits -CharacterClass Digit -Repeat |
            Select-Object -ExpandProperty Pattern |
            should -Be '(?<Digits>\d+)'
    }

    it 'Can write an expression that will always fail' {
        New-RegEx -Not | select -ExpandProperty Pattern | should -Be '(?!)'
    }

    it 'Can write an anti expression' {
        New-RegEx -Not foo | Select-Object -ExpandProperty pattern | should -Be '\A((?!(foo)).)*\Z'
    }

    it 'Can Be -Atomic' {
        New-RegEx -Atomic -Pattern 'do', 'die' -Or | select-object -expand Pattern | should -BeLike '(?>*do*|*die*)'
    }

    it 'Can Be -Greedy or -Lazy (or both)' {
        New-RegEx -Pattern '(.|\s)' -Greedy -Lazy | Select-Object -ExpandProperty Pattern | Should -Be '(.|\s)*?'
    }

    it "Doesn't have to capture (with -NoCapture)" {
        New-RegEx -NoCapture '\d+' |
            Select-Object -ExpandProperty Pattern | should -Be '(?:\d+)'
    }

    it 'Can -Be optional' {
        New-RegEx -Pattern do, die -Or -Optional | select-object -expand Pattern | should -BeLike '(?:*do*|*die*)?'
    }

    it 'Can use Saved Expressions (with the format ?<Name>)' {
        New-RegEx ?<Digits> | Select-Object -ExpandProperty Pattern | should -BeLike '*\d+*'
    }

    it 'Can write conditionals' {
        New-RegEx '((?<Digit>\d)|(?<NotDigit>\D))' -If Digit -Then '\D' -Else '\d' |
            Use-RegEx -IsMatch 'a1' |
            should -Be $true
        New-RegEx '(?<Digit>\d)' |
            New-RegEx -If Digit -Then '[abcdef]'
    }

    it 'Can write backreferences' {
        New-RegEx -Backreference previousCapture |
            Select-Object -ExpandProperty Pattern |
            Should -Be '\k<previousCapture>'

        $(New-RegEx -Backreference 1).ToString() |
            Should -Be '\1'
    }

    it 'Can refer to other saved captures in a pattern (by putting ?<CaptureName> without leading comments)' {
        New-RegEx -Pattern '?<Digits>' |
            Use-RegEx -IsMatch -Match 1 |
            should -Be true
    }

    it 'Can rename a saved capture (by putting (?<NewCaptureName>?<OldCaptureName>)' {
        New-RegEx -Pattern '(?<MyDigits>?<Digits>)' |
            Use-RegEx -Extract -Match 1 |
            Select-Object -ExpandProperty MyDigits |
            should -Be 1
    }

    it 'Can match -Until a pattern' {
        $writeRegexCmd = $ExecutionContext.SessionState.InvokeCommand.GetCommand('New-RegEx','Function')

        New-RegEx -Pattern \<\# |
            New-RegEx -Name Block -Until \#> |
            New-RegEx -Pattern \#\> |
            Use-RegEx -Extract -Match $writeRegexCmd.Definition |
            Select-Object -ExpandProperty Block |
            should -BeLike *New-RegEx*
    }

    context '-Between' {
        it 'Makes it easy to match double quotes' {
            New-RegEx -Between '"' -Name InQuotes |
                Use-RegEx -Extract -Match 'this is not in quotes. "This Is \"". This is not in quotes' |
                Select-Object -ExpandProperty InQuotes |
                should -Be 'This Is \"'
        }

        it 'Makes it easy to match single quotes' {
            New-RegEx -Between "'" -Name InQuotes -EscapeSequence "''" |
                Use-RegEx -Extract -Match "this is not in quotes. 'This Is '''.  This is not in quotes" |
                Select-Object -ExpandProperty InQuotes |
                should -Be "This Is ''"
        }

        it 'Makes it easy to match block comments' {
            New-RegEx -Name BlockComment -Between '\<\#', '\#\>' -EscapeSequence '' |
                Use-RegEx -Extract -Match @'
1 <#BlockComment#>
2
'@ |
                Select-Object -ExpandProperty BlockComment |
                should -Be BlockComment

        }
    }

    it 'Can Match a series of Digits up to a -DigitMax' {
        $r = New-RegEx -DigitMax 16 -StartAnchor '^' -NotBefore '\d'
        $r.Match("16").Success | Should -Be $true
        $r.Match("17").Success | Should -Be $false
    }

    it 'Can refer to a capture generator (parameters can -Be passed with () or {})' {
        New-RegEx -Pattern '?<BalancedCode>{(}' |
            Use-RegEx -IsMatch -Match '({}' |
            should -Be $false

        New-RegEx -Pattern '?<BalancedCode>({)' |
            Use-RegEx -IsMatch -Match '({}' |
            should -Be $true
    }


}


describe Export-RegEx {
    it 'Can Export a RegEx as a -Variable' {
        Export-RegEx -Name Digits -As Variable | should -BeLike '$digits*=*\d+*'
    }
    it 'Can Export to a Path' {

        if ($env:TEMP) {
            Export-RegEx -Name Digits -Path $env:TEMP
            Get-Content (Join-Path $env:TEMP 'Digits.regex.txt') -raw |
                should -BeLike *\d+*
        }
    }
    if (-not $env:Agent_ID -and $PSVersionTable.Platform -ne 'Unix') { # Skipping this test in AzureDev ops due to disk issues
        it 'Can Export -As a Script to a Temporary Path' {
            if ($env:TEMP) {
                $exFile= (Join-Path $env:TEMP Digits.ps1)
                Export-RegEx -Name Digits -Path $exFile -As Script
                $exFileContent = Get-Content $exFile -Raw
                $exFileContent|
                    should -BeLike '*\d+*'
                $exFileContent | should -BeLike '*function UseRegex*'
                $exFileContent | should -BeLike '*Set-Alias ?<Digits> UseRegex*'
                $exFile | Remove-Item
            }
        }
        it 'Can Export a Temporary Pattern' {

            Import-RegEx -Pattern '(?<SomeMoreDigits>\d+)'
            Export-RegEx -Name SomeMoreDigits
            $createdFile = Get-Module Irregular |
                Split-Path |
                Join-Path -Path { $_ } -ChildPath RegEx  |
                Get-ChildItem -Filter SomeMoreDigits.regex.txt

            $createdFile.Name | should -Be SomeMoreDigits.regex.txt
            $createdFile | Remove-Item
        }
    }
    if ($PSVersionTable.Platform -ne 'Unix') {
        it 'Will complain when passed a filepath and multiple names (if -As is file)' {
            {
                Export-RegEx -Name Digits, OptionalWhitespace -Path "$env:TEMP\DigitsAndWhitespace.regex.txt" -ErrorAction Stop
            } | should throw
        }
        if (-not $env:Agent_ID) {
            it 'Can Export a RegEx as a -Script' {
                $irregularPath = Get-Module Irregular | Split-Path
                $ex = Export-RegEx -Name Digits -As Script
                Get-Command Export-RegEx |
                    Select-Object -ExpandProperty Module|
                    Remove-Module
                . ([ScriptBlock]::Create($ex))

                'abc123' |
                    ?<Digits> |
                    Select-Object -Property *
                Import-Module $irregularPath
            }
        }
    }
}

describe 'Expressions' {
    $rootDir = $PSScriptRoot
    
    foreach ($file in Get-ChildItem $rootDir -Recurse) {
        if ($file.name -notlike '*.regex.input*') {
            continue
        }

        $regexName, $restOfName = $file.name -split '\.regex\.input', 2
        $specificInput =
            if ($restOfName -match '\.(?<Number>\d+)\.') {
                $extension = $restOfName -replace '\.(?<Number>\d+)\.', ''
                $matches.Number
            } else {
                $extension =  $restOfName
                ''
            }
        $outputFile =
            $(foreach ($siblingFile in $file.directory.EnumerateFiles()) {
                if ($siblingFile -notlike '*.regex.output*') {
                    continue
                }
                $siblingFile = [IO.FileInfo]$siblingFile
                $siblingFileName, $restofSiblingFile = $siblingFile.name -split '\.regex\.output', 2
                if ($siblingFileName -ne $regexName) { continue }
                if ($specificInput -and $siblingFileName -notlike "*.$specificInput.*") { continue }
                $siblingFile;break
            })

        $regexFullName =
            if ($file.Directory.Name -ne 'Regex') {
                '?<' + $file.Directory.Name + "_" + $regexName + '>'
            } else {
                "?<$regexName>"
            }


        $testScriptBlock =  ([ScriptBlock]::Create(@"
`$inputFile = '$($file.FullName.Replace("'","''"))'
`$outputFile = '$(if ($outputFile) {$outputFile.FullName.Replace("'","''")})'
`$regexResult = Get-Item -LiteralPath `$inputFile | $regexFullName
`$regexResult | should -Not -Be `$null
"@+ {
    if (-not $outputFile) { return }
    $outputFileInfo = [IO.FileInfo]$outputFile
    $outputFileContent = [IO.File]::ReadAllText($outputFile)
    foreach ($item in $regexResult) {
        $outputFileContent | should -BeLike "*$($item)*"
    }
}))


        it "$regexFullName" $testScriptBlock


    }

    context '?<EmailAddress>' {
        it 'Will extract an email and domain' {
            'foo@bar.com' |
                ?<EmailAddress> -Extract |
                % {
                    $_.Username | should -Be foo
                    $_.Domain | should -Be bar.com
                }
        }
        it 'Will not match a psuedo-email' {
            'psued@oemail' | ?<EmailAddress>  |should -Be $null
        }
    }
    context '?<Code_Namespace>' {
        it 'Will match a namespace' {
            $nsExtract = @'
namespace MyNamespace {
    public class foo() {}
}
'@ | ?<Code_Namespace> -Extract
            $nsExtract.Content | should -BeLike '{*foo()*}'
            $nsExtract.Name | should -Be MyNamespace
        }
    }

    context '?<REST_Variable>' {
        it 'Will extract variables in a REST url string' {
            $restMatches = ?<REST_Variable> -Match 'https://`$server/[organization]/{project}?api-version=`$apiVersion'
            $restMatches[0].Value | should -Be '/`$server'
            $restMatches[1].Value | should -Be '/[organization]'
            $restMatches[2].Value | should -Be '/{project}'
            $restMatches[3].Value | should -Be '?api-version=`$apiVersion'
        }
    }

}

describe 'Generators' {
    context '?<MultilineComment>' {
        it 'Will auto-detect comment types' {
            Get-Module Irregular |
                Split-Path |
                Get-ChildItem -Recurse -Filter *.ps1 |
                Select-Object -First 1 |
                ?<MultilineComment> -Count 1 |
                should -BeLike '<#*#>'
        }
        it 'Will extract comments from a function' {
            Get-Command New-RegEx |
                ?<MultilineComment> -Count 1 |
                should -BeLike '<#*#>'
        }
    }
}

describe Set-Regex {
    it 'Lets you store Regular Expressions'  {
        Get-RegEx -Name Digits |
            Set-Regex -Confirm:$false
    }
    if (-not $env:Agent_ID -and $PSVersionTable.Platform -ne 'Unix') {
        it 'Lets you declare them temporarily' {
            Set-Regex -Name Period -Pattern '\.' -Temporary
            Use-RegEx -Pattern '?<Period>' -Match '.' -IsMatch | should -Be true
        }


        it 'Will infer the name' {
            Set-Regex -Pattern '(?<Period>\.)' -Description 'A period' -Temporary
        }
        it 'Will complain if the pattern was not named' {
            {Set-Regex -Pattern blah -Temporary -errorAction Stop} | should throw
        }
        it 'Can append to a an inline description' {
            Set-Regex -Pattern '# a math symbol
(?<MathSymbol>\p{Sm})' -Description 'Using the special character class math' -Temporary


            New-RegEx '?<MathSymbol>' | should -BeLike '*\p{Sm}*'
        }

        it 'Can accept the output of New-RegEx' {
            New-RegEx -LiteralCharacter := -Name ColonOrEquals |
                Set-Regex
            Get-Module Irregular |
                Split-Path |
                Join-Path -ChildPath 'Regex' |
                Join-Path -ChildPath 'ColonOrEquals.regex.txt' |
                Remove-Item
        }
    }
    it 'Can set a regex in an arbitrary path' {
        if ($env:TEMP) {
            Set-RegEx -Pattern '(?<Period>\.)' -Path $env:TEMP -PassThru |
                Select-Object -ExpandProperty Name |
                should -Be Period.regex.txt
        } elseif (Test-Path '/tmp') {
            Set-RegEx -Pattern '(?<Period>\.)' -Path '/tmp' -PassThru | 
                Select-Object -ExpandProperty Name |
                should -Be Period.regex.txt
        } else {
            'No temp directory found'
        }
    }
}

describe Remove-RegEx {
    it 'Can remove a regex' {
        Set-RegEx -Name Period -Pattern '\.' -Description "A Period" -Temporary -PassThru
        $periodRegex = Get-RegEx -Name Period
        Remove-RegEx -Name Period -Confirm:$false
        if ($periodRegex.Path) {
            Test-Path $periodRegex.Path | Should -Be $false
        }
        $ExecutionContext.SessionState.InvokeCommand.GetCommand('?<Period>', 'Alias') | Should -Be $null        
    }
}