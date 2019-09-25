|Name|Description|IsGenerator|
|:---|:----------|:----------|
|ArithmeticOperator|Simple Arithmetic Operators|False|
|BalancedBrackets|Matches content in brackets, as long as it is balanced|False|
|BalancedCode|Matches code balanced by a \[, \{, or \(<br/>|True|
|BalancedCurlyBracket|Matches content in \{}, as long as it is balanced|False|
|BalancedParenthesis|Matches content in parenthesis, as long as it is balanced|False|
|Colon|Matches a literal colon|False|
|Decimals|Matching any series of decimals is deceptively complicated|False|
|Digits|Repeated Digits|False|
|DoubleQuotedString|Matches a double quoted string, with an optional escape sequence \(defaulting to backtick or backslash).<br/>|True|
|EmailAddress|An email address \(captures the UserName and Domain)|False|
|Equals|A literal equal sign =|False|
|GenericBalancingExpression|This expression matches content that is within "balanced" punctuation.<br/>It does not validate that each type of open/close punctuation is valid.<br/>Just that it any open punctuation is matched by closed punctuation.|False|
|GetMarkupTag|Gets one or more specific markup tags.  By default, anchor tags.<br/>|True|
|JSON_Property|A property within a JSON string|False|
|LeadingWhitespace|Matches zero or more whitespaces after the beginning of a line.|False|
|LineEndsWithColon|This returns lines that end with a colon|False|
|LineStartOrEnd|This will match either a line start or end.|False|
|MultilineComment|Matches Multline Comments from a variety of languages.<br/>Currently supported: PowerShell, C#, C++, JavaScript, Ruby, HTML, and XML<br/>When this generator is used with a piped in file, the extension will autodetect the format.<br/>If the format could not be autodetected, the match will always fail.<br/>|True|
|Namespace|Finds a Namespace \(captures the Name and the Content between \{})|False|
|NewLine|A newline \(in either Windows \(\r\n) or Unix \(\n) form)|False|
|NextColon|This returns the position of the next colon, but not the next colon itself.|False|
|NextWord|Finds all repeated text that is not whitespace or punctuation.|False|
|NumberAndExponent|Matches a decimal number with an exponent.|False|
|NumberSign|A number sign \#|False|
|OptionalWhitespace|This matches zero or more whitespace characters|False|
|PowerShell_Attribute|Matches a PowerShell attribute declaration|False|
|PowerShell_AttributeValue|This expression extracts the key/value pairs from a PowerShell attribute body \(the content within parenthesis)|False|
|PowerShell_Function|Matches PowerShell functions|False|
|PowerShell_HelpField|Matches specific fields from inline help<br/>|True|
|PowerShell_ScriptBlock|Matches a PowerShell script block|False|
|Punctuation|Matches any single or repeated punctuation.|False|
|RegularExpression_Group|Matches groups in a regular expression|False|
|SingleQuotedString|Matches a single quoted string, with an optional escape sequence \(defaulting to two single quotes or a backslash).<br/>|True|
|StartsWithCapture|Matches if the string starts with a named capture, and captures the FirstCaptureName|False|
|Tag|This will match a balanced markup tag.|False|
|TrueOrFalse|Matches the literal 'true' or 'false'|False|