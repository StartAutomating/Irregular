<#

PowerShell works with Regular Expressions in many different ways.  
The most common way you'll encounter Regex in PowerShell is with one of the built-in operators:
* -match
* -replace
* -split
#>

'the quick fox jumped over the lazy dog' -match '\s' 
 # -match will return true (because the string contains whitespace)
  
 'the quick fox jumped over the lazy dog' -split '\s'
 # -split will each word into multiple strings (splitting on whitespace).
 
'the quick fox jumped over the lazy dog' -replace '\s', '_'
 # -replace will replace each whitespace with an underscore.  
 # It's a bit of an odd duck in PowerShell operators, since it takes two parameters on it's right side.
 # The first parameter is the regular expression.
 # The second parameter is the replacement.


<#
The -match, -replace, and -split operators are very handy, but have their shortcomings:

* -match will only find if it matches, and populate $matches with the first match.
* -replace doesn't directly allow for custom processing

Additionally, none of the operators use the Regex option IgnorePatternWhitespace, which limits you to concise, simple regular expressions.

You can address these shortcomings by using the [Regex] type accelerator (which points to [System.Text.RegularExpressions.Regex])

#>

 # Matches will return each whitespace
[Regex]::Matches('the quick fox jumped over the lazy dog', '\s')

 # Split will split on each whitespace
[Regex]::Split('the quick fox jumped over the lazy dog', '\s')

 # Replace will replace each whitespace with _
[Regex]::Replace('the quick fox jumped over the lazy dog', '\s', '_')

 # Replace, using a lambda
[Regex]::Replace('the quick fox jumped over the lazy dog', '\s', {
    return '_'
}, 'IgnoreCase, IgnorePatternWhitespace')


<#
You can create also create a new instance of a [Regex] class to save an expression you use often
#>

$whitespace = [Regex]::new('\s # whitespace', 'IgnoreCase,IgnorePatternWhitespace')

$whitespace.Matches('the quick fox jumped over the lazy dog')
