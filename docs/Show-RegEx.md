Show-RegEx
----------

### Synopsis
Shows a Regular Expression and it's output.

---

### Description

Displays Regular Expressions, with their match output.

---

### Related Links
* [Get-Regex](Get-Regex.md)

* [Use-Regex](Use-Regex.md)

---

### Examples
> EXAMPLE 1

```PowerShell
-Match abc123def456
```

---

### Parameters
#### **Pattern**
The regular expression.  If the pattern starts with a saved capture name, it will use the saved pattern.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|

#### **Match**
One or more strings to match.

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[String[]]`|false   |2       |true (ByPropertyName)|

#### **Remove**
If set, will remove the regular expression matches from the text.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **Replace**
If set, will replace the text with a replacement string.
For more information about replacement strings, see:
https://docs.microsoft.com/en-us/dotnet/standard/base-types/substitutions-in-regular-expressions

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|

#### **Transform**
If provided, will transform each match with a replacement string.
For more information about replacement strings, see:
https://docs.microsoft.com/en-us/dotnet/standard/base-types/substitutions-in-regular-expressions

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|

#### **Option**
The regular expression options, by default, MultiLine, IgnoreCase and IgnorePatternWhitespace
|Default Multiline,IgnoreCase,IgnorePatternWhitespace
|Multiselect
Valid Values:

* None
* IgnoreCase
* Multiline
* ExplicitCapture
* Compiled
* Singleline
* IgnorePatternWhitespace
* RightToLeft
* ECMAScript
* CultureInvariant
* NonBacktracking

|Type            |Required|Position|PipelineInput        |Aliases|
|----------------|--------|--------|---------------------|-------|
|`[RegexOptions]`|false   |4       |true (ByPropertyName)|Options|

#### **CaseSensitive**
Indicates that the cmdlet makes matches case-sensitive. By default, matches are not case-sensitive.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **Timeout**
The match timeout.  By default, one second.

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[TimeSpan]`|false   |named   |true (ByPropertyName)|

---

### Outputs
* Irregular.RegEx.Output

---

### Syntax
```PowerShell
Show-RegEx [-Pattern] <String> [[-Match] <String[]>] [-Remove] [-Replace <String>] [-Transform <String>] [[-Option] {None | IgnoreCase | Multiline | ExplicitCapture | Compiled | Singleline | IgnorePatternWhitespace | RightToLeft | ECMAScript | CultureInvariant | NonBacktracking}] [-CaseSensitive] [-Timeout <TimeSpan>] [<CommonParameters>]
```
