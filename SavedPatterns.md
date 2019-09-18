|Name|Description|IsGenerator|
|:---|:----------|:----------|
|ArithmeticOperator|Simple Arithmetic Operators|False|
|BalancedBrackets|Matches content in brackets, as long as it is balanced|False|
|BalancedCode|Matches code balanced by a [, {, or (
|True|
|BalancedCurlyBracket|Matches content in {}, as long as it is balanced|False|
|BalancedParenthesis|Matches content in parenthesis, as long as it is balanced|False|
|Colon|Matches a colon|False|
|ColonOrEqual|Matches either a colon or an equal sign.|False|
|Decimals|Matching any series of decimals is deceptively complicated|False|
|Digits|Repeated Digits|False|
|EmailAddress|An email address (captures the UserName and Domain)|False|
|GenericBalancingExpression|This expression matches content that is within "balanced" punctuation.
It does not validate that each type of open/close punctuation is valid.
Just that it any open punctuation is matched by closed punctuation.|False|
|GetMarkupTag|Gets one or more specific markup tags.  By default, anchor tags.
|True|
|JSONProperty|A property within a JSON string|False|
|LineEndsWithColon|This returns lines that end with a colon|False|
|LineStartOrEnd|This will match either a line start or end.|False|
|MultilineComment|Matches Multline Comments from a variety of languages.
Currently supported: PowerShell, C#, C++, JavaScript, Ruby, HTML, and XML
When this generator is used with a piped in file, the extension will autodetect the format.
If the format could not be autodetected, the match will always fail.
|True|
|NewLine|A newline (in either Windows (\r\n) or Unix (\n) form)|False|
|NextColon|This returns the position of the next colon, but not the next colon itself.|False|
|NextWord|Finds all repeated text that is not whitespace or punctuation.|False|
|NumberAndExponent|Matches a decimal number with an exponent.|False|
|OptionalWhitespace|This matches zero or more whitespace characters|False|
|PowerShellAttributeKeyValuePair|This expression extracts the key/value pairs from a PowerShell attribute body (the content within parenthesis)|False|
|PowerShellDoubleQuoteString|A PowerShell double-quoted string|False|
|PowerShellInlineHelpField|Matches specific fields from inline help
|True|
|PowerShellSingleQuoteString|Matches a single quoted string, escaped by double single-quotes|False|
|Punctuation|Matches any single or repeated punctuation.|False|
|StartsWithCapture|Matches if the string starts with a named capture, and captures the FirstCaptureName|False|
|Tag|This will match a balanced markup tag.|False|
|TrueOrFalse|Matches the literal 'true' or 'false'|False|
