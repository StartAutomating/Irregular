<div align='center'>
<img src='Assets/Irregular_970_90.png' />
<h2>Regular Expressions made Strangely Simple</h2>
<h3>A PowerShell module that helps you understand, use, and build Regular Expressions.</h3>
<a href='https://dev.azure.com/StartAutomating/Irregular/_build/latest?definitionId=1&branchName=master'>
<img src='https://dev.azure.com/StartAutomating/Irregular/_apis/build/status/StartAutomating.Irregular?branchName=master' />
</a>
</div>


#### Understanding Regular Expressions

Regular Expressions are powerful but feared.

They are powerful because they can can be used to parse anything.

They are feared because their syntax is so strange it obscures basic understanding.

Once you understand some basics of that syntax, regular expressions become a lot less scary (although they still look strange)

1. You can stack a RegEx!  (by placing them in capture groups () )
2. You can extract from a RegEx!  ( by naming a capture group (?\<Digits\>\d+)).
3. A Regex can have comments! ( # Like this in .NET  ( or like (?#this comment) in ECMAScript ) ).
4. You don't have to do it all in one expression! 

Irregular comes with a number of useful named expressions, and lets you create more.

To see the expressions that ship with Irregular, run:

~~~PowerShell
Get-RegEx
~~~
You can use them in all sorts of interesting ways in PowerShell with the capture name:

~~~PowerShell
?<Digits>                    # Returns the Named Regular Expression Digits
'abc' | ?<Digits>            # Returns nothing, since nothing in abc matches the expression Digits
'123abc456' | ?<Digits>      # Returns two matches, 123 and 456
"abc123" | ?<Digits> -Until  # Returns the content until the next set of digits
'1. one. 2. two.  3. three'| # Returns each number and the content after it
    ?<Digits> -Split -IncludeMatch
'123abc456def' |             # Returns only matches of odd Digits
    ?<Digits> -Where { $_.Digits % 2 } 
~~~

You can use these expressions to build more complicated parsing in less code.
For instance, here's a Regular Expression that can match a simple calculator:

    
~~~PowerShell
Write-Regex -StartAnchor StringStart -Pattern @(
    ?<OptionalWhitespace>
    ?<Digits>
    ?<OptionalWhitespace>
    ?<ArithmeticOperator>
    ?<OptionalWhitespace>
    ?<Digits>
    ?<OptionalWhitespace>
) -EndAnchor StringEnd
~~~


Irregular also contains a colorized PowerShell formatter for all Regular Expressions.
This provides syntax highlighting that can make complicated expressions easier to read.
![RegexSyntaxHighlighting](Assets/RegexSyntaxHighlighting.gif)


#### Building Regular Expressions

Irregular gives you a handy command to simplify writing regular expressions, Write-RegEx.

Write-RegEx helps you build regular expressions without constantly resorting to a manual.

~~~PowerShell
Write-Regex -CharacterClass Digit -Repeat # This writes the Regex (\d+)
~~~
You can pipe regular expression written this way into Write-Regex to compound expressions
    
~~~PowerShell
# This will produce a regular expression that matches a doubly-quoted string (allowing for escaped quotes)
Write-RegEx -Pattern '"' |
        Write-RegEx -CharacterClass Any -Repeat -Lazy -Before (
            Write-RegEx -Pattern '"' -NotAfter '\\'
        ) |
        Write-RegEx -Pattern '"'
~~~

The parameters for Write-RegEx have help, so if you ever want to understand a little more about what makes a RegEx, you can use:

~~~PowerShell
Get-Help Write-RegEx -Full
~~~

#### Using Regular Expressions

PowerShell is already a very potent tool for dealing using Regular Expressions.

You can use the -match, -split, and -replace operators to do basic operations with Regular Expressions.

You can use any saved expression with these operators by putting it in paranthesis, for instance:

~~~PowerShell
"abc123" -match (?<Digits>)
~~~

This works because without any additional parameters, running a saved expression will return a saved expression.

Additionally, each named capture can do a number of other things with a match:

* -Where will filter matches
* -IsMatch will return a boolean if the pattern matches
* -Measure will count the number of matches
* -Remove will strip any matches
* -Replace will replace matches with a replacement string
* -ReplaceIf will replace matches if a condition is met
* -Transform will return matches transformed by a replacement string
* -Coerce will coerce returned strings into strongly typed data
* -Split will split the string on the matches (-Count number of times)
* -Until will return the string until the next match
* -RightToLeft will perform operations from right to left

To see all of the things you can do with any Regular Expression, run:

~~~PowerShell
Get-Help Use-Regex -Full
~~~

Matches are also decorated with information about the input and position.  This allows you to pipe one match into another search:

~~~PowerShell
"number: 1
string: 'hello'" | ?<NewLine> -Split |  
    Foreach-Object {
        $key = $_ | ?<Colon> -Until -Trim -IncludeMatch
        $value = $key | ?<LineStartOrEnd> -Until -Trim
        @{$key.Trim(':')=$value}
    }
~~~
