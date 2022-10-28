New-RegEx
---------
### Synopsis
Creates a regular expression

---
### Description

Helps to simplifify creating regular expressions

---
### Related Links
* [Use-RegEx](Use-RegEx.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
New-RegEx -CharacterClass Any -Repeat
```

#### EXAMPLE 2
```PowerShell
New-RegEx -CharacterClass Digit -Repeat -Name Digits
```

#### EXAMPLE 3
```PowerShell
# A regular expression for a quoted string (with \" and `" as valid escape sequences)
New-RegEx -Pattern '"' |
        New-RegEx -CharacterClass Any -Repeat -Lazy -Before (
            New-RegEx -Pattern '"' -NotAfter '\\|`'
        ) |
        New-RegEx -Pattern '"'
```

#### EXAMPLE 4
```PowerShell
# A regular expression for an email address.
```
New-RegEx -Description "Matches an Email Address" |
    New-RegEx -Name UserName -Pattern (
        New-RegEx -CharacterClass Word -Comment "Match the username, which starts with a word character" |
            New-RegEx -CharacterClass Word -LiteralCharacter '-.' -Min 0 -Comment "and can contain any number of word characters, dashes, or dots"
    ) |
    New-RegEx -LiteralCharacter '@' -Comment "Followed by an @"|
    New-RegEx -Name Domain -Pattern (
        New-RegEx -CharacterClass Word  -Comment "The domain starts with a word character" |
            New-RegEx -CharacterClass Word -LiteralCharacter '-' -Min 0 -Comment "and can contain any words with dashes," |
            New-RegEx -NoCapture -Pattern (
                New-RegEx -LiteralCharacter '.' -Comment "followed by at least one suffix (which starts with a dot),"|
                    New-RegEx -CharacterClass Word -Comment "followed by a word character," |
                    New-RegEx -CharacterClass Word -LiteralCharacter '-' -Min 0 -Comment "followed by any word characters or dashes"
            ) -Min 1
    )
#### EXAMPLE 5
```PowerShell
# Writes a pattern for multiline comments
New-RegEx -Pattern \<\# |
    New-RegEx -Name Block -Until \#\> |
    New-RegEx -Pattern \#\>
```

---
### Parameters
#### **Pattern**

One or more regular expressions.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:false



---
#### **Name**

If provided, will name the capture



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **CharacterClass**

One or more character classes.



Valid Values:

* Any
* .
* Word
* \w
* NonWord
* \W
* Whitespace
* \s
* NonWhitespace
* \S
* Digit
* \d
* NonDigit
* \D
* Escape
* \e
* Tab
* \t
* CarriageReturn
* \r
* NewLine
* \n
* VerticalTab
* \v
* FormFeed
* \f
* UpperCaseLetter
* \p{Lu}
* LowerCaseLetter
* \p{Ll}
* TitleCaseLetter
* \p{Lt}
* ModifierLetter
* \p{Lm}
* OtherLetter
* \p{Lo}
* Letter
* \p{L}
* NonSpacingMark
* \p{Mn}
* CombiningMark
* \p{Mc}
* EnclosingMark
* \p{Me}
* Mark
* \p{M}
* Number
* \p{N}
* NumberDecimalDigit
* \p{Nd}
* NumberLetter
* \p{Nl}
* NumberOther
* \p{No}
* PunctuationConnector
* \p{Pc}
* PunctuationDash
* \p{Pd}
* PunctuationOpen
* \p{Ps}
* PunctuationClose
* \p{Pe}
* PunctuationInitialQuote
* \p{Pi}
* PunctuationFinalQuote
* \p{Pf}
* PunctuationOther
* \p{Po}
* Punctuation
* \p{P}
* SymbolMath
* \p{Sm}
* SymbolCurrency
* \p{Sc}
* SymbolModifier
* \p{Sk}
* SymbolOther
* \p{So}
* Symbol
* \p{S}
* SeparatorSpace
* \p{Zs}
* SeparatorLine
* \p{Zl}
* SeparatorParagraph
* \p{Zp}
* Separator
* \p{Z}
* Control
* \p{C}
* NonUpperCaseLetter
* \P{Lu}
* NonLowerCaseLetter
* \P{Ll}
* NonTitleCaseLetter
* \P{Lt}
* NonModifierLetter
* \P{Lm}
* NonOtherLetter
* \P{Lo}
* NonLetter
* \P{L}
* NonNonSpacingMark
* \P{Mn}
* NonCombiningMark
* \P{Mc}
* NonEnclosingMark
* \P{Me}
* NonMark
* \P{M}
* NonNumber
* \P{N}
* NonNumberDecimalDigit
* \P{Nd}
* NonNumberLetter
* \P{Nl}
* NonNumberOther
* \P{No}
* NonPunctuationConnector
* \P{Pc}
* NonPunctationDash
* \P{Pd}
* NonPunctationOpen
* \P{Ps}
* NonPunctationClose
* \P{Pe}
* NonPunctationInitialQuote
* \P{Pi}
* NonPunctationFinalQuote
* \P{Pf}
* NonPunctuationOther
* \P{Po}
* NonPunctuation
* \P{P}
* NonSymbolMath
* \P{Sm}
* NonSymbolCurrency
* \P{Sc}
* NonSymbolModifier
* \P{Sk}
* NonSymbolOther
* \P{So}
* NonSymbol
* \P{S}
* NonSeparatorSpace
* \P{Zs}
* NonSeparatorLine
* \P{Zl}
* NonSeparatorParagraph
* \P{Zp}
* NonSeparator
* \P{Z}
* NonControl
* \P{C}



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **LiteralCharacter**

If provided, will match any number of specific literal characters.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **UnicodeCharacter**

If provided, will match any number of unicode characters.
Note:  Unless the RegEx is case-sensitive, this will match both uppercase and lowercase.
To make a RegEx explicitly case-sensitive, use New-RegEx -Modifier IgnoreCase -Not



> **Type**: ```[Int32[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **ExcludeCharacterClass**

When provided with -CharacterClass, -LiteralCharacter, or -UnicodeCharacter, will subtract one set of characters from the other.
Otherwise, will match any character classes that are not excluded.



Valid Values:

* Any
* .
* Word
* \w
* NonWord
* \W
* Whitespace
* \s
* NonWhitespace
* \S
* Digit
* \d
* NonDigit
* \D
* Escape
* \e
* Tab
* \t
* CarriageReturn
* \r
* NewLine
* \n
* VerticalTab
* \v
* FormFeed
* \f
* UpperCaseLetter
* \p{Lu}
* LowerCaseLetter
* \p{Ll}
* TitleCaseLetter
* \p{Lt}
* ModifierLetter
* \p{Lm}
* OtherLetter
* \p{Lo}
* Letter
* \p{L}
* NonSpacingMark
* \p{Mn}
* CombiningMark
* \p{Mc}
* EnclosingMark
* \p{Me}
* Mark
* \p{M}
* Number
* \p{N}
* NumberDecimalDigit
* \p{Nd}
* NumberLetter
* \p{Nl}
* NumberOther
* \p{No}
* PunctuationConnector
* \p{Pc}
* PunctuationDash
* \p{Pd}
* PunctuationOpen
* \p{Ps}
* PunctuationClose
* \p{Pe}
* PunctuationInitialQuote
* \p{Pi}
* PunctuationFinalQuote
* \p{Pf}
* PunctuationOther
* \p{Po}
* Punctuation
* \p{P}
* SymbolMath
* \p{Sm}
* SymbolCurrency
* \p{Sc}
* SymbolModifier
* \p{Sk}
* SymbolOther
* \p{So}
* Symbol
* \p{S}
* SeparatorSpace
* \p{Zs}
* SeparatorLine
* \p{Zl}
* SeparatorParagraph
* \p{Zp}
* Separator
* \p{Z}
* Control
* \p{C}
* NonUpperCaseLetter
* \P{Lu}
* NonLowerCaseLetter
* \P{Ll}
* NonTitleCaseLetter
* \P{Lt}
* NonModifierLetter
* \P{Lm}
* NonOtherLetter
* \P{Lo}
* NonLetter
* \P{L}
* NonNonSpacingMark
* \P{Mn}
* NonCombiningMark
* \P{Mc}
* NonEnclosingMark
* \P{Me}
* NonMark
* \P{M}
* NonNumber
* \P{N}
* NonNumberDecimalDigit
* \P{Nd}
* NonNumberLetter
* \P{Nl}
* NonNumberOther
* \P{No}
* NonPunctuationConnector
* \P{Pc}
* NonPunctationDash
* \P{Pd}
* NonPunctationOpen
* \P{Ps}
* NonPunctationClose
* \P{Pe}
* NonPunctationInitialQuote
* \P{Pi}
* NonPunctationFinalQuote
* \P{Pf}
* NonPunctuationOther
* \P{Po}
* NonPunctuation
* \P{P}
* NonSymbolMath
* \P{Sm}
* NonSymbolCurrency
* \P{Sc}
* NonSymbolModifier
* \P{Sk}
* NonSymbolOther
* \P{So}
* NonSymbol
* \P{S}
* NonSeparatorSpace
* \P{Zs}
* NonSeparatorLine
* \P{Zl}
* NonSeparatorParagraph
* \P{Zp}
* NonSeparator
* \P{Z}
* NonControl
* \P{C}



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **ExcludeLiteralCharacter**

When provided with -CharacterClass, -LiteralCharacter, or -UnicodeCharacter, will subtract one set of characters from the other.
Otherwise, will match any characters that are not one of the provided literal characters.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **ExcludeUnicodeCharacter**

When provided with -CharacterClass, -LiteralCharacter, or -UnicodeCharacter, will subtract one set of characters from the other.
Otherwise, will match any characters that are not one of the provided unicode characters.
Note:  Unless the RegEx is case-sensitive, this will match both uppercase and lowercase.
To make a RegEx explicitly case-sensitive, use New-RegEx -Modifier IgnoreCase -Not



> **Type**: ```[Int32[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **DigitMax**

If provided, will match digits up to a value.



> **Type**: ```[UInt32]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Backreference**

The name or number of a backreference (a reference to a previous capture)



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **NotAfter**

A negative lookbehind (?<!). This pattern that must not match after the current position..



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **NotBefore**

A negative lookahead (?!). This pattern must not match before the current position.



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **After**

A positive lookbehind (?<=). This pattern that must match after the current position.



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Before**

A positive lookahead (?=). This pattern that must match before the current position.



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Repeat**

If set, will match repeated occurances of a character class or pattern



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Greedy**

If set, repeated occurances will be matched greedily.
A greedy match is the last possible match that completes a condition.
For example when you run "abcabc" -match 'a.*c' (a greedy match)
$matches will be abcabc



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Lazy**

If set, repeated occurances will be matched lazily.
A lazy match is the first possible match that completes a conidition.
For example, when you run "abcabc" -match 'a.*?c' (a lazy match)
$matches will be abc



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Min**

The minimum number of repetitions.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Max**

The maximum number of repetitions.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **If**

If provided, inserts a Regular Expression conditional.



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Then**

If the pattern provided in -If is true, it will attempt to continue to match with the pattern provided in -Then



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Else**

If the pattern provided in -If if false, it will attempt to continue to match the with the pattern provided in -Else.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Until**

If provided, will match all content until any of these conditions or the end of the string are found.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Comment**

A comment (yes, they exist in Regular Expressions)



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Description**

A description.  This will be added to the top of the expression as a comment.



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Not**

If set and -CharacterClass is provided, will match anything but the provided set of character classes.
If set and -Expression is provided, will match anything that does not contain the expression
If set and neither -Expression or -CharacterClass is provided, will do an empty lookbehind (this will always fail)
If set and -Modifier is provided, will negate the modifier.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Or**

If set, will match any of a number of character classes, or any number of patterns.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **StartAnchor**

The start anchor.



Valid Values:

* Boundary
* \b
* NotBoundary
* \B
* LineStart
* ^
* LineEnd
* $
* StringStart
* \A
* StringEnd
* \z
* LastLineEnd
* \Z



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **EndAnchor**

The end anchor.



Valid Values:

* Boundary
* \b
* NotBoundary
* \B
* LineStart
* ^
* LineEnd
* $
* StringStart
* \A
* StringEnd
* \z
* LastLineEnd
* \Z



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Modifier**

Regular expression modifiers.  These affect the way the expression is interpreted.
Modifiers can be turned off by passing -Modifier and -Not.
If -NoCapture is provided, modifiers will only apply to the current group.



Valid Values:

* Multiline
* m
* Singleline
* s
* IgnoreCase
* i
* IgnorePatternWhitespace
* x
* ExplicitCapture
* n



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Optional**

If set, will make the pattern optional



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Atomic**

If set, will make the pattern atomic.  This will allow one and only one match.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **NoCapture**

# If set, will make the pattern non-capturing.  This will omit the group from the resulting match.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **PrePattern**

A regular expression that occurs before the generated regular expression.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByValue)



---
#### **TimeOut**

The timeout of the regular expression.  By default, 5 seconds.



> **Type**: ```[TimeSpan]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Between**

If provided, will match between a given string or pair of strings.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **EscapeSequence**

The escape sequence used with -Between.  By default, a slash.



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Denormalized**

If set, comments in the regular expression will not be normalized.
By default, all comments that do not start on the beginning are normalized to start at the same column.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **Parameter**

Named parameters.  These are only valid if the regex is using a Generator script.



> **Type**: ```[IDictionary]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **ArgumentList**

A list of arguments.  These are only valid if the regex is using a Generator script.



> **Type**: ```[PSObject[]]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
### Outputs
* [Text.RegularExpressions.Regex](https://learn.microsoft.com/en-us/dotnet/api/System.Text.RegularExpressions.Regex)


* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
New-RegEx [[-Pattern] <String[]>] [-Name <String>] [-CharacterClass <String[]>] [-LiteralCharacter <String[]>] [-UnicodeCharacter <Int32[]>] [-ExcludeCharacterClass <String[]>] [-ExcludeLiteralCharacter <String[]>] [-ExcludeUnicodeCharacter <Int32[]>] [-DigitMax <UInt32>] [-Backreference <String>] [-NotAfter <String>] [-NotBefore <String>] [-After <String>] [-Before <String>] [-Repeat] [-Greedy] [-Lazy] [-Min <Int32>] [-Max <Int32>] [-If <String>] [-Then <String[]>] [-Else <String[]>] [-Until <String[]>] [-Comment <String>] [-Description <String>] [-Not] [-Or] [-StartAnchor <String>] [-EndAnchor <String>] [-Modifier <String[]>] [-Optional] [-Atomic] [-NoCapture] [-PrePattern <String[]>] [-TimeOut <TimeSpan>] [-Between <String[]>] [-EscapeSequence <String>] [-Denormalized] [-Parameter <IDictionary>] [-ArgumentList <PSObject[]>] [<CommonParameters>]
```
---
