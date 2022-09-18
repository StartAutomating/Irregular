
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
#### EXAMPLE 1
```PowerShell
-Match abc123def456
```

---
### Parameters
#### **Pattern**

The regular expression.  If the pattern starts with a saved capture name, it will use the saved pattern.



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Match**

One or more strings to match.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **Remove**

If set, will remove the regular expression matches from the text.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Replace**

If set, will replace the text with a replacement string.
For more information about replacement strings, see:
https://docs.microsoft.com/en-us/dotnet/standard/base-types/substitutions-in-regular-expressions



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Transform**

If provided, will transform each match with a replacement string.
For more information about replacement strings, see:
https://docs.microsoft.com/en-us/dotnet/standard/base-types/substitutions-in-regular-expressions



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
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



> **Type**: ```[RegexOptions]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **CaseSensitive**

Indicates that the cmdlet makes matches case-sensitive. By default, matches are not case-sensitive.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Timeout**

The match timeout.  By default, one second.



> **Type**: ```[TimeSpan]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Outputs
Irregular.RegEx.Output


---
### Syntax
```PowerShell
Show-RegEx [-Pattern] &lt;String&gt; [[-Match] &lt;String[]&gt;] [-Remove] [-Replace &lt;String&gt;] [-Transform &lt;String&gt;] [[-Option] {None | IgnoreCase | Multiline | ExplicitCapture | Compiled | Singleline | IgnorePatternWhitespace | RightToLeft | ECMAScript | CultureInvariant}] [-CaseSensitive] [-Timeout &lt;TimeSpan&gt;] [&lt;CommonParameters&gt;]
```
---


