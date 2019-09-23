#requires -Module Pester, Irregular
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
        Get-Regex -Name Digits -As String | should be '\d+'
    }
    it 'Can get a RegEx -As a File' {
        Get-Regex -Name Digits -As File | 
            Select-Object -ExpandProperty Name | 
            should be Digits.regex.txt
    }
    it 'Can get a RegEx -As a Pattern' {
        Get-Regex -Name Digits -As Pattern | should belike '*\d+*'
    }
    it 'Can get a RegEx -As a Hashtable' {
        Get-RegEx -Name Digits -As Hashtable | should belike '@{*'
    }
    it 'Can get a RegEx -As a Variable' {
        Get-RegEx -Name Digits -As Variable | should belike '$digits*=*\d+*'
    }
    it 'Can get a RegEx -As an Alias' {
        Get-RegEx -Name Digits -As Alias | should be 'Set-Alias ?<Digits> Use-RegEx'
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
        (?<AnySymbol>).GetType() | should be ([Regex])
    }
}

describe Show-Regex {
        it 'Is an interactive tool to preview simple Regex operations' {
            $o = Show-RegEx -Pattern '?<Digits>' -Match abc123def456
            $o.Output.Count | should be 2
        }
        it 'Can -Remove content' {
            $o = Show-RegEx -Pattern '?<Digits>' -Match abc123def456 -Remove
            $o.Output | should be abcdef
        }
        it 'Can -Replace content' {
            $o = Show-RegEx -Pattern '?<Digits>' -Match abc123def456 -Remove
            $o.Output | should be abcdef
        }
        it 'Will return the Regex is no other parameters than Pattern are passed' {
            $o = Show-RegEx -Pattern '?<Digits>'
            "$o" |should belike *\d+*
        }
        it 'Will show that invalid patterns are invalid' {
            $o = Show-RegEx -Pattern '('
            $o.IsValid | should be $false
        }
    }

describe Use-Regex {
    it 'Is normally used with an alias of a named expression (e.g. ?<Digits>)' {
        (?<Digits>).GetType() | should be ([Regex])
    }
    it 'Lets you find all matches' {
        ?<Digits> -Match "123abc456" |
            Measure-Object |
            Select-Object -ExpandProperty Count|
            should be 2
    }
    it 'Lets you find a single match' {
        ?<Digits> -Match '123abc456' -Count 1 |
            Measure-Object |
            Select-Object -ExpandProperty Count|
            should be 1
    }
    it 'Lets you piped in multiple inputs' {
        "123abc456", "def789" | ?<Digits> |
            Measure-Object |
            Select-Object -ExpandProperty Count |
            should be 3
    }
    it 'Can search -RightToLeft' {
        "123abc456" |
            ?<Digits> -RightToLeft -Count 1 |
            Select-Object -ExpandProperty Value |
            should be 456
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
            should be 123
    }
    it 'Can -Coerce results with a [ScriptBlock]' {
        '123abc456' |
            ?<Digits> -Coerce @{
                Digits={($_ -as [int]) * 2}
            } -Count 1 |
            Select-Object -ExpandProperty Digits |
            should be 246
    }
    it 'Can filter results with -Where' {
        @('123abc456' |
            ?<Digits> -Where {$_.Digits %2 } |
            should be '123')
    }
    it 'Can -Remove matches' {
        '123abc456' |?<Digits> -Remove | should be abc
    }
    it 'Can -Replace matches' {
        '123abc456' |?<Digits> -Replace ' $1 ' | should be ' 123 abc 456 '
    }
    it 'Can -ReplaceIf a conidition is met' {
        '123abc456' |
            ?<Digits> -ReplaceIf @{ { $_.Digits % 2 } = '$1 (is odd) '} |
            should be '123 (is odd) abc456'
    }
    it 'Can use a -Replacer [ScriptBlock]' {
        '123abc456' |
            ?<Digits> -ReplaceEvaluator { '_' } |
            should be _abc_
    }
    it 'Can -Replace a -Count' {
        '123abc456' | ?<Digits> -Remove -Count 1 | should be abc456
    }

    it 'Can -Transform matches into something else' {
        @('123abc456' | ?<Digits> -Transform '-$1' ) -join ' ' | should be '-123 -456'
    }
    it 'Can transform a match -If a condition is met' {
        '123abc456' |
            ?<Digits> -If @{{$_.Digits %2 } = '$1 is odd' } |
            should be '123 is odd'
    }

    it 'Can run a script -If a condition is met' {
        '123abc456' |
            ?<Digits> -If @{{$_.Digits %2 } = {"$([int]$_.Digits * 2) is even" }} |
            should be '246 is even'
    }

    it 'Can return an arbitrary value -If a condition is met' {
        $randomNumber = [Random]::new().Next()
        '123' | ?<Digits> -If @{{$_} = $randomNumber } | should be $randomNumber
    }

    it 'Will -Coerce before -If' {
        '123abc456' |?<Digits> -Coerce @{Digits=[int]} -If @{{$_.Digits %2 } = {"$($_.Digits * 2 ) is even" }} | should be '246 is even'
    }

    context '-Split' {
        it 'Will -Split a string' {
            "key:value" |?<Colon> -Split | Select-Object -First 1 | should be key
        }
        it 'Will -Split a string -RightToLeft' {
            'key: value' | ?<Colon> -Split -Trim -RightToLeft | Select-Object -First 1 | should be value
        }

        it 'Will -Split -StartAt at point' {
            'prefix: key: value' |
                ?<Colon> -Split -StartAt 'prefix:'.Length -Trim |
                Select-Object -First 1 |
                should be key
        }
    
        it 'Can -IncludeMatch with a -Split' {
            $k,$s, $v = "key:value" |?<Colon> -Split -IncludeMatch
            $s | should be ':'
            $k,$s, $v = "key:value" |?<Colon> -Split -IncludeMatch -RightToLeft
            $s | should be ':'
        }

        it 'Will -Split -Count number of times' {
             'key: value: with a colon' | 
                ?<Colon> -Split -Count 1 -Trim |
                Select-Object -First 1 -Skip 1 |
                should be 'value: with a colon'
        }

        it 'Will -Split -Count items from -RightToLeft' {
            'lkey: value:value:rkey' |
                ?<Colon> -Split -Count 1 -RightToLeft -Trim |
                Select-Object -First 1 |
                should be 'rkey'
        }

        
    }

    context '-Until' {
        it 'Can get content -Until a point' {
        "How much wood would a woodchuck chuck if a woodchuck could chuck wood?" |
            ?<Punctuation> -Until |
            should be "How much wood would a woodchuck chuck if a woodchuck could chuck wood"
        }
        it 'Can -IncludeMatch with -Until' {
            "How much wood would a woodchuck chuck if a woodchuck could chuck wood?" |
                ?<Punctuation> -Until -IncludeMatch |
                should be "How much wood would a woodchuck chuck if a woodchuck could chuck wood?"
        }
        it 'Can -Measure the distance -Until a match' {
            'key:value' |?<Colon> -Until -Measure | should be 3
            'key:value' |?<Colon> -Until -Measure -RightToLeft | should be 7
        }
    }
    
    

    

    it 'Can make any RegEx -CaseSensitive' {
        Use-RegEx -Pattern 'param' -Match 'Param' -IsMatch -CaseSensitive | should be $false
    }

    it 'Can -Measure the number of matches' {
        Use-RegEx -Pattern '(?>\r\n|\n)' -Measure -Match ([Environment]::NewLine * 6) |
            should be 6

        Use-RegEx -Pattern '(?>\r\n|\n)' -Measure -Match ([Environment]::NewLine * 8) -Count 4 |
            should be 4
    }

    it 'Can seek from one match to the next' {
        @($txt = "true or false or true or false"
        $m = $txt | ?<TrueOrFalse> -Count 1
        do {
            $m
            $m = $m | ?<TrueOrFalse> -Count 1
        } while ($m)) -join ' ' | # Looping over each match until non are found.  ?<TrueOrFalse> is an alias to Use-RegEx
            should be 'true false true false'
    }

    it 'Can seek from one match to the next (from -RightToLeft)' {
        @($txt = "true or false or true or false"
        $m = $txt | ?<TrueOrFalse> -Count 1 -RightToLeft
        do {
            $m
            $m = $m | ?<TrueOrFalse> -Count 1 -RightToLeft
        } while ($m)) -join ' ' | # Looping over each match until non are found.  ?<TrueOrFalse> is an alias to Use-RegEx
            should be 'false true false true'
    }

    context 'Special Piping Behavior' {
        it 'Will match the contents if piped in a file' {
            (Get-Command Write-RegEx | 
                Select-Object -ExpandProperty ScriptBlock | 
                Select-Object -ExpandProperty File) -as [IO.FileInfo] |
            ?<PowerShellInlineHelpField> |
                Select-Object -ExpandProperty InputObject |
                Select-Object -ExpandProperty Name |
                should be Write-Regex.ps1
        }

        it 'Will match the script contents if passed an external script' {
            Get-Command ((Get-Command Write-RegEx | 
                Select-Object -ExpandProperty ScriptBlock | 
                Select-Object -ExpandProperty File)) |
                ?<PowerShellInlineHelpField> |
                Select-Object -ExpandProperty InputObject |
                Select-Object -ExpandProperty Name |
                should be Write-Regex.ps1
        }

        it 'Will match the definition if passed a function' {
            Get-Command Write-RegEx | 
                ?<PowerShellInlineHelpField> |
                Select-Object -ExpandProperty InputObject |
                Select-Object -ExpandProperty Name |
                should be Write-RegEx
        }
    }

    context Generators {
        it 'Can use a .regex.ps1 to generate a Pattern' {
            "{'hello world'}" | ?<BalancedCode> |
                Select-Object -ExpandProperty Value |
                should be "{'hello world'}"
        }
        it 'Can pass named -Parameter[s] to a generator' {
            "{'hello world'}" | ?<BalancedCode> -Parameter @{Open='{'} |
                Select-Object -ExpandProperty Value |
                should be "{'hello world'}"
        }

        it 'Can pass -Arguments to a generator' {
            "['hello world']" | ?<BalancedCode> -Arguments '['  |
                Select-Object -ExpandProperty Value |
                should be "['hello world']"
        }

        it 'Can use a dynamic generator' {
            $rx = Use-RegEx -Generator {param($t) "$t"} -Parameter @{t='hi'}
            "$rx"| should belike *hi*
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


describe Write-Regex {
    it "Helps you write -CharacterClasses" {
        Write-RegEx -CharacterClass LowerCaseLetter |
            Select-Object -ExpandProperty Pattern |
            should be '\p{Ll}'
    }
    it "Lets you look for repeated content" {
        Write-RegEx -CharacterClass Digit -Repeat |
            Select-Object -ExpandProperty Pattern |
            should be '\d+'
    }



    it "Simplifies lookahead with -Before (aka -LookAhead)" {
        Write-RegEx -Expression 'q' -LookAhead u | # Matches a q that is followed by a u
            Select-Object -ExpandProperty Pattern |
            should be 'q(?=u)'
    }

    it 'Simplifies lookbehind with -After (aka -LookBehind)' {
        Write-RegEx -Expression u -LookBehind q | # Matches a u that is preceeded by a q
            Select-Object -ExpandProperty Pattern |
            should be '(?<=q)u'
    }

    it 'Simplifies negative lookahead with -NotBefore' {
        Write-RegEx -Expression q -NotBefore u | # Matches a q that isn't followed by a u
            Select-Object -ExpandProperty Pattern |
            should be 'q(?!u)'
    }


    it "Simplifies negative lookbehind with -NotAfter (aka -NegativeLookBehind)" {
        Write-RegEx -Expression '"' -NegativeLookBehind '\\' |
            Select-Object -ExpandProperty Pattern |
            should be '(?<!\\)"'
    }
    it "Can pipe to itself to compound expressions" {
        Write-RegEx -Pattern '"' |
            Write-RegEx -CharacterClass Any -Repeat -Lazy -Before (
                Write-RegEx -Pattern '"' -NotAfter '\\|`'
            ) |
            Write-RegEx -Pattern '"' |
            Select-Object -ExpandProperty Pattern |
            should be '".+?(?=(?<!\\|`)")"'
    }

    it 'Can combine more than on -CharacterClass' {
        Write-RegEx -CharacterClass Digit, Word |
            Select-Object -ExpandProperty Pattern |
            should be '[\d\w]'
    }

    it 'Can negate a -CharacterClass' {
        Write-RegEx -CharacterClass Digit, Word -Not |
            Select-Object -ExpandProperty Pattern |
            should be '[^\d\w]'
    }

    it 'Can handle -LiteralCharacters' {
        ?<> -Name UserName -LiteralCharacter .- -CharacterClass Word -Repeat |
            ?<> (?<> '\@' -NoCapture) |
        ?<> -Name Domain -LiteralCharacter .- -CharacterClass Word -Repeat
    }

    it 'Can use a -StartAnchor or -EndAnchor' {
        Write-RegEx -CharacterClass Whitespace -Min 0 -StartAnchor LineStart -EndAnchor LineEnd |
            Select-Object -ExpandProperty Pattern |
            should be '^\s{0,}$'
    }

    it 'Can check for  -Min and -Max occurances' {
        Write-RegEx -CharacterClass Whitespace -Min 0 -Max 4 |
            Select-Object -ExpandProperty Pattern |
            should be '\s{0,4}'
    }

    it 'Can leave a comment' {
        Write-RegEx -CharacterClass Whitespace -Comment "Whitespace" |
            Select-Object -ExpandProperty Pattern |
            should belike "\s # Whitespace*"
    }

    it 'Can write a description' {
        Write-RegEx -CharacterClass Whitespace -Description "Whitespace" |
            Select-Object -ExpandProperty Pattern |
            should be "# Whitespace$([Environment]::NewLine)\s"
    }

    it 'Can name a capture' {
        Write-RegEx -Name Digits -CharacterClass Digit -Repeat |
            Select-Object -ExpandProperty Pattern |
            should be '(?<Digits>\d+)'
    }

    it 'Can write an expression that will always fail' {
        Write-RegEx -Not | select -ExpandProperty Pattern | should be '(?!)'
    }

    it 'Can write an anti expression' {
        Write-RegEx -Not foo | Select-Object -ExpandProperty pattern | should be '\A((?!(foo)).)*\Z'
    }

    it 'Can be -Atomic' {
        Write-RegEx -Atomic -Pattern 'do', 'die' -Or | select-object -expand Pattern | should be '(?>(do|die))'
    }

    it 'Can be -Greedy or -Lazy (or both)' {
        Write-RegEx -Pattern '(.|\s)' -Greedy -Lazy | Select-Object -ExpandProperty Pattern | Should be '(.|\s)*?'
    }

    it "Doesn't have to capture (with -NoCapture)" {
        Write-RegEx -NoCapture '\d+' |
            Select-Object -ExpandProperty Pattern | should be '(?:\d+)'
    }

    it 'Can be optional' {
        Write-RegEx -Pattern do, die -Or -Optional | select-object -expand Pattern | should be '(do|die)?'
    }

    it 'Can use Saved Expressions (with the format ?<Name>)' {
        Write-RegEx ?<Digits> | Select-Object -ExpandProperty Pattern | should belike '*\d+*'
    }

    it 'Can write conditionals' {
        Write-RegEx '((?<Digit>\d)|(?<NotDigit>\D))' -If Digit -Then '\D' -Else '\d' |
            Use-RegEx -IsMatch 'a1' |
            should be $true
        Write-RegEx '(?<Digit>\d)' |
            Write-RegEx -If Digit -Then '[abcdef]'
    }

    it 'Can write backreferences' {
        Write-RegEx -Backreference previousCapture |
            Select-Object -ExpandProperty Pattern |
            Should be '\k<previousCapture>'

        $(Write-RegEx -Backreference 1).ToString() |
            Should be '\1'
    }

    it 'Can refer to other saved captures in a pattern (by putting ?<CaptureName> without leading comments)' {
        Write-RegEx -Pattern '?<Digits>' |
            Use-RegEx -IsMatch -Match 1 |
            should be true
    }
    
    it 'Can rename a saved capture (by putting (?<NewCaptureName>?<OldCaptureName>)' {
        Write-RegEx -Pattern '(?<MyDigits>?<Digits>)' |
            Use-RegEx -Extract -Match 1 |
            Select-Object -ExpandProperty MyDigits |
            should be 1
    }

    it 'Can refer to a capture generator (parameters can be passed with () or {})' {
        Write-RegEx -Pattern '?<BalancedCode>{(}' |
            Use-RegEx -IsMatch -Match '({}' |
            should be $false

        Write-RegEx -Pattern '?<BalancedCode>({)' |
            Use-RegEx -IsMatch -Match '({}' |
            should be $true
    }
}


describe Export-RegEx {
    it 'Can Export a RegEx as a -Variable' {
        Export-RegEx -Name Digits -As Variable | should belike '$digits*=*\d+*'
    }    
    it 'Can Export to a Path' {
        
        if ($env:TEMP) {
            Export-RegEx -Name Digits -Path $env:TEMP
            Get-Content (Join-Path $env:TEMP 'Digits.regex.txt') -raw |
                should belike *\d+*
        }
    }
    if (-not $env:Agent_ID -and $PSVersionTable.Platform -ne 'Unix') { # Skipping this test in AzureDev ops due to disk issues
        it 'Can Export -As a Script to a Temporary Path' {
            if ($env:TEMP) {
                $exFile= (Join-Path $env:TEMP Digits.ps1)
                Export-RegEx -Name Digits -Path $exFile -As Script
                $exFileContent = Get-Content $exFile -Raw 
                $exFileContent|
                    should belike '*\d+*'
                $exFileContent | should belike '*function UseRegex*'
                $exFileContent | should belike '*Set-Alias ?<Digits> UseRegex*'
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

            $createdFile.Name | should be SomeMoreDigits.regex.txt
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
                iex $ex

                'abc123' |
                    ?<Digits> | 
                    Select-Object -Property *
                Import-Module $irregularPath
            }
        }
    }
}

describe 'Expressions' {
    context '?<EmailAddress>' {
        it 'Will extract an email and domain' {
            'foo@bar.com' | 
                ?<EmailAddress> -Extract |
                % { 
                    $_.Username | should be foo
                    $_.Domain | should be bar.com
                } 
        }
        it 'Will not match a psuedo-email' {
            'psued@oemail' | ?<EmailAddress>  |should be $null
        }
    }
    context '?<Namespace>' {
        it 'Will match a namespace' {
            $nsExtract = @'
namespace MyNamespace {
    public class foo() {} 
}
'@ | ?<Namespace> -Extract  
            $nsExtract.Content | should belike '{*foo()*}'
            $nsExtract.Name | should be MyNamespace
        }
    }
}

describe 'Generators' {
    context '?<MultilineComment>' {
        it 'Will auto-detect comment types' {
            Get-Module Irregular | 
                Split-Path | 
                Get-ChildItem -Recurse -Filter *.ps1 | 
                ?<MultilineComment> -Count 1 |
                should belike '<#*#>'
        }
        it 'Will extract comments from a function' {
            Get-Command Write-Regex | 
                ?<MultilineComment> -Count 1 |
                should belike '<#*#>'
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
            Use-RegEx -Pattern '?<Period>' -Match '.' -IsMatch | should be true
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


            Write-RegEx '?<MathSymbol>' | should belike '*\p{Sm}*'
        }
    
        it 'Can accept the output of Write-Regex' { 
            Write-RegEx -LiteralCharacter := -Name ColonOrEquals |
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
            Set-RegEx -Pattern '(?<Period>\.)' -Path $env:TEMP
            Get-ChildItem -LiteralPath $env:temp -Filter Period.regex.txt | 
                Select-Object -ExpandProperty Name |
                should be Period.regex.txt
        } else {
            'No temp directory found'
        }
    }
}