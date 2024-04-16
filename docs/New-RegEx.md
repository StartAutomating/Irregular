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
> EXAMPLE 1

```PowerShell
New-RegEx -CharacterClass Any -Repeat
```
> EXAMPLE 2

```PowerShell
New-RegEx -CharacterClass Digit -Repeat -Name Digits
```
A regular expression for a quoted string (with \" and `" as valid escape sequences)

```PowerShell
New-RegEx -Pattern '"' |
        New-RegEx -CharacterClass Any -Repeat -Lazy -Before (
            New-RegEx -Pattern '"' -NotAfter '\\|`'
        ) |
        New-RegEx -Pattern '"'
```
A regular expression for an email address.

```PowerShell
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
```
Writes a pattern for multiline comments

```PowerShell
New-RegEx -Pattern \<\# |
    New-RegEx -Name Block -Until \#\> |
    New-RegEx -Pattern \#\>
```

---

### Parameters
#### **Pattern**
One or more regular expressions.

|Type        |Required|Position|PipelineInput|Aliases   |
|------------|--------|--------|-------------|----------|
|`[String[]]`|false   |1       |false        |Expression|

#### **Name**
If provided, will name the capture

|Type      |Required|Position|PipelineInput|Aliases    |
|----------|--------|--------|-------------|-----------|
|`[String]`|false   |named   |false        |CaptureName|

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
* MarkSpacing
* \p{Mc}
* MarkNonSpacing
* \p{Mn}
* MarkEnclosing
* \p{Me}
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

|Type        |Required|Position|PipelineInput|Aliases                |
|------------|--------|--------|-------------|-----------------------|
|`[String[]]`|false   |named   |false        |CC<br/>CharacterClasses|

#### **LiteralCharacter**
If provided, will match any number of specific literal characters.

|Type        |Required|Position|PipelineInput|Aliases                 |
|------------|--------|--------|-------------|------------------------|
|`[String[]]`|false   |named   |false        |LC<br/>LiteralCharacters|

#### **UnicodeCharacter**
If provided, will match any number of unicode characters.
Note:  Unless the RegEx is case-sensitive, this will match both uppercase and lowercase.
To make a RegEx explicitly case-sensitive, use New-RegEx -Modifier IgnoreCase -Not

|Type       |Required|Position|PipelineInput|Aliases                 |
|-----------|--------|--------|-------------|------------------------|
|`[Int32[]]`|false   |named   |false        |UC<br/>UnicodeCharacters|

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

|Type        |Required|Position|PipelineInput|Aliases                                                            |
|------------|--------|--------|-------------|-------------------------------------------------------------------|
|`[String[]]`|false   |named   |false        |XCC<br/>ExcludeCC<br/>ExcludeCharacterClasses<br/>NotCharacterClass|

#### **ExcludeLiteralCharacter**
When provided with -CharacterClass, -LiteralCharacter, or -UnicodeCharacter, will subtract one set of characters from the other.
Otherwise, will match any characters that are not one of the provided literal characters.

|Type        |Required|Position|PipelineInput|Aliases                                                               |
|------------|--------|--------|-------------|----------------------------------------------------------------------|
|`[String[]]`|false   |named   |false        |XLC<br/>ExcludeLC<br/>ExcludeLiteralCharacters<br/>NotLiteralCharacter|

#### **ExcludeUnicodeCharacter**
When provided with -CharacterClass, -LiteralCharacter, or -UnicodeCharacter, will subtract one set of characters from the other.
Otherwise, will match any characters that are not one of the provided unicode characters.
Note:  Unless the RegEx is case-sensitive, this will match both uppercase and lowercase.
To make a RegEx explicitly case-sensitive, use New-RegEx -Modifier IgnoreCase -Not

|Type       |Required|Position|PipelineInput|Aliases                                                               |
|-----------|--------|--------|-------------|----------------------------------------------------------------------|
|`[Int32[]]`|false   |named   |false        |XUC<br/>ExcludeUC<br/>ExcludeUnicodeCharacters<br/>NotUnicodeCharacter|

#### **DigitMax**
If provided, will match digits up to a value.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[UInt32]`|false   |named   |false        |

#### **Backreference**
The name or number of a backreference (a reference to a previous capture)

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |false        |

#### **NotAfter**
A negative lookbehind (?<!). This pattern that must not match after the current position..

|Type      |Required|Position|PipelineInput|Aliases           |
|----------|--------|--------|-------------|------------------|
|`[String]`|false   |named   |false        |NegativeLookBehind|

#### **NotBefore**
A negative lookahead (?!). This pattern must not match before the current position.

|Type      |Required|Position|PipelineInput|Aliases          |
|----------|--------|--------|-------------|-----------------|
|`[String]`|false   |named   |false        |NegativeLookAhead|

#### **After**
A positive lookbehind (?<=). This pattern that must match after the current position.

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[String]`|false   |named   |false        |LookBehind|

#### **Before**
A positive lookahead (?=). This pattern that must match before the current position.

|Type      |Required|Position|PipelineInput|Aliases  |
|----------|--------|--------|-------------|---------|
|`[String]`|false   |named   |false        |LookAhead|

#### **Repeat**
If set, will match repeated occurances of a character class or pattern

|Type      |Required|Position|PipelineInput|Aliases  |
|----------|--------|--------|-------------|---------|
|`[Switch]`|false   |named   |false        |Repeating|

#### **Greedy**
If set, repeated occurances will be matched greedily.
A greedy match is the last possible match that completes a condition.
For example when you run "abcabc" -match 'a.*c' (a greedy match)
$matches will be abcabc

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **Lazy**
If set, repeated occurances will be matched lazily.
A lazy match is the first possible match that completes a conidition.
For example, when you run "abcabc" -match 'a.*?c' (a lazy match)
$matches will be abc

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **Min**
The minimum number of repetitions.

|Type     |Required|Position|PipelineInput|Aliases|
|---------|--------|--------|-------------|-------|
|`[Int32]`|false   |named   |false        |AtLeast|

#### **Max**
The maximum number of repetitions.

|Type     |Required|Position|PipelineInput|Aliases|
|---------|--------|--------|-------------|-------|
|`[Int32]`|false   |named   |false        |AtMost |

#### **If**
If provided, inserts a Regular Expression conditional.

|Type      |Required|Position|PipelineInput|Aliases     |
|----------|--------|--------|-------------|------------|
|`[String]`|false   |named   |false        |IfExpression|

#### **Then**
If the pattern provided in -If is true, it will attempt to continue to match with the pattern provided in -Then

|Type        |Required|Position|PipelineInput|Aliases       |
|------------|--------|--------|-------------|--------------|
|`[String[]]`|false   |named   |false        |ThenExpression|

#### **Else**
If the pattern provided in -If if false, it will attempt to continue to match the with the pattern provided in -Else.

|Type        |Required|Position|PipelineInput|Aliases       |
|------------|--------|--------|-------------|--------------|
|`[String[]]`|false   |named   |false        |ElseExpression|

#### **Until**
If provided, will match all content until any of these conditions or the end of the string are found.

|Type        |Required|Position|PipelineInput|
|------------|--------|--------|-------------|
|`[String[]]`|false   |named   |false        |

#### **Comment**
A comment (yes, they exist in Regular Expressions)

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |false        |

#### **Description**
A description.  This will be added to the top of the expression as a comment.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |false        |

#### **Not**
If set and -CharacterClass is provided, will match anything but the provided set of character classes.
If set and -Expression is provided, will match anything that does not contain the expression
If set and neither -Expression or -CharacterClass is provided, will do an empty lookbehind (this will always fail)
If set and -Modifier is provided, will negate the modifier.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **Or**
If set, will match any of a number of character classes, or any number of patterns.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

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

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |false        |

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

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |false        |

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

|Type        |Required|Position|PipelineInput|Aliases|
|------------|--------|--------|-------------|-------|
|`[String[]]`|false   |named   |false        |Mode   |

#### **Optional**
If set, will make the pattern optional

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **Atomic**
If set, will make the pattern atomic.  This will allow one and only one match.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **NoCapture**
# If set, will make the pattern non-capturing.  This will omit the group from the resulting match.

|Type      |Required|Position|PipelineInput|Aliases               |
|----------|--------|--------|-------------|----------------------|
|`[Switch]`|false   |named   |false        |NonCapturing<br/>NoCap|

#### **PrePattern**
A regular expression that occurs before the generated regular expression.

|Type        |Required|Position|PipelineInput |Aliases      |
|------------|--------|--------|--------------|-------------|
|`[String[]]`|false   |named   |true (ByValue)|PreExpression|

#### **TimeOut**
The timeout of the regular expression.  By default, 5 seconds.

|Type        |Required|Position|PipelineInput|
|------------|--------|--------|-------------|
|`[TimeSpan]`|false   |named   |false        |

#### **Between**
If provided, will match between a given string or pair of strings.

|Type        |Required|Position|PipelineInput|
|------------|--------|--------|-------------|
|`[String[]]`|false   |named   |false        |

#### **EscapeSequence**
The escape sequence used with -Between.  By default, a slash.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |false        |

#### **Denormalized**
If set, comments in the regular expression will not be normalized.
By default, all comments that do not start on the beginning are normalized to start at the same column.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **Parameter**
Named parameters.  These are only valid if the regex is using a Generator script.

|Type           |Required|Position|PipelineInput|Aliases   |
|---------------|--------|--------|-------------|----------|
|`[IDictionary]`|false   |named   |false        |Parameters|

#### **ArgumentList**
A list of arguments.  These are only valid if the regex is using a Generator script.

|Type          |Required|Position|PipelineInput|Aliases           |
|--------------|--------|--------|-------------|------------------|
|`[PSObject[]]`|false   |named   |false        |Arguments<br/>Args|

---

### Outputs
* [Text.RegularExpressions.Regex](https://learn.microsoft.com/en-us/dotnet/api/System.Text.RegularExpressions.Regex)

* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)

---

### Syntax
```PowerShell
New-RegEx [[-Pattern] <String[]>] [-Name <String>] [-CharacterClass <String[]>] [-LiteralCharacter <String[]>] [-UnicodeCharacter <Int32[]>] [-ExcludeCharacterClass <String[]>] [-ExcludeLiteralCharacter <String[]>] [-ExcludeUnicodeCharacter <Int32[]>] [-DigitMax <UInt32>] [-Backreference <String>] [-NotAfter <String>] [-NotBefore <String>] [-After <String>] [-Before <String>] [-Repeat] [-Greedy] [-Lazy] [-Min <Int32>] [-Max <Int32>] [-If <String>] [-Then <String[]>] [-Else <String[]>] [-Until <String[]>] [-Comment <String>] [-Description <String>] [-Not] [-Or] [-StartAnchor <String>] [-EndAnchor <String>] [-Modifier <String[]>] [-Optional] [-Atomic] [-NoCapture] [-PrePattern <String[]>] [-TimeOut <TimeSpan>] [-Between <String[]>] [-EscapeSequence <String>] [-Denormalized] [-Parameter <IDictionary>] [-ArgumentList <PSObject[]>] [<CommonParameters>]
```
