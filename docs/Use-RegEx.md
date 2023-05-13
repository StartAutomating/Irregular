Use-RegEx
---------




### Synopsis
Uses a saved regular expression.



---


### Description

Uses a saved regular expression, or an expression provided with -Parameter.

Use-RegEx is normally called with an alias that is the name of a saved RegEx, for example:

?<Digits>



---


### Related Links
* [Get-RegEx](Get-RegEx.md)



* [New-RegEx](New-RegEx.md)





---


### Examples
#### EXAMPLE 1
```PowerShell
Use-RegEx -Pattern '.' -Text "abc"
```

#### EXAMPLE 2
```PowerShell
# ?<TrueOrFalse> is a saved RegEx and alias to Use-RegEx
```

#### EXAMPLE 3
```PowerShell
$txt = "true or false or true or false"
$m = $txt | ?<TrueOrFalse> -Count 1
do {
    $m
    $m = $m | ?<TrueOrFalse> -Count 1 -Scan
} while ($m) # Looping over each match until non are found.  ?<TrueOrFalse> is an alias to Use-RegEx
```



---


### Parameters
#### **Match**

One or more strings to match.






|Type        |Required|Position|PipelineInput        |Aliases                                   |
|------------|--------|--------|---------------------|------------------------------------------|
|`[String[]]`|false   |1       |true (ByPropertyName)|InputObject<br/>Text<br/>Matches<br/>Value|



#### **IsMatch**

If set, will return a boolean indicating if the regular expression matched






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |



#### **Measure**

If set, will measure the number of matches.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |



#### **Count**

The count of matches to return, or the number of matches split or replaced.






|Type     |Required|Position|PipelineInput|Aliases|
|---------|--------|--------|-------------|-------|
|`[Int32]`|false   |named   |false        |Number |



#### **StartAt**

The starting position of the match






|Type     |Required|Position|PipelineInput        |Aliases   |
|---------|--------|--------|---------------------|----------|
|`[Int32]`|false   |named   |true (ByPropertyName)|StartingAt|



#### **Remove**

If set, will remove the regular expression matches from the text.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |



#### **Replace**

If set, will replace the text with a replacement string.
For more information about replacement strings, see:
https://docs.microsoft.com/en-us/dotnet/standard/base-types/substitutions-in-regular-expressions






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |false        |



#### **Scan**




|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |



#### **ReplaceIf**

If provided, will replace the match if any of the conditions exist.






|Type           |Required|Position|PipelineInput|
|---------------|--------|--------|-------------|
|`[IDictionary]`|false   |named   |false        |



#### **ReplaceEvaluator**

If provided, will each match will be passed to the Replacer ScriptBlock.
The values returned from this script block will replace the match.






|Type           |Required|Position|PipelineInput|Aliases               |
|---------------|--------|--------|-------------|----------------------|
|`[ScriptBlock]`|false   |named   |false        |Replacer<br/>Evaluator|



#### **Split**

If set, will split the input text according to the expression.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |



#### **Until**

If set, will get the text until the expression.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |



#### **IncludeMatch**

If -IncludeMatch and -Until are provided, will include the match with the result of -Until.
If -IncludeMatch and -Split are provided, will include the matches with the result of -Split.
If -IncludeMatch is provided with -Extract, a .Match property will be included in the result.
If neither -Split or -Until is provided, this parameter is ignored.






|Type      |Required|Position|PipelineInput|Aliases                       |
|----------|--------|--------|-------------|------------------------------|
|`[Switch]`|false   |named   |false        |IncludingMatch<br/>OutputMatch|



#### **IncludeInputObject**

If -IncludeInputObject is provided, will add any piped in input object to extracted output.






|Type      |Required|Position|PipelineInput|Aliases                                   |
|----------|--------|--------|-------------|------------------------------------------|
|`[Switch]`|false   |named   |false        |IncludingInputObject<br/>OutputInputObject|



#### **Trim**

If set, will trim returned strings.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |



#### **Extract**

If set, will extract capture groups into a custom object.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |



#### **PSTypeName**

If provided, will add typename information to the returned objects.
This implies -Extract.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |false        |



#### **Transform**

If provided, will transform each match with a replacement string.
For more information about replacement strings, see:
https://docs.microsoft.com/en-us/dotnet/standard/base-types/substitutions-in-regular-expressions






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |false        |



#### **Coerce**

If provided, will cast named capture groups to a given type.  This implies -Extract.






|Type           |Required|Position|PipelineInput|Aliases|
|---------------|--------|--------|-------------|-------|
|`[IDictionary]`|false   |named   |false        |Cast   |



#### **Where**

If provided, will filter the extracted data of a match.






|Type           |Required|Position|PipelineInput|
|---------------|--------|--------|-------------|
|`[ScriptBlock]`|false   |named   |false        |



#### **If**

One or more conditions.  If the condition is true, the value will be returned.
If the value is a script block, it will be executed.
If the value is a string, it will be treated as a Replacement string (like -Transform).






|Type           |Required|Position|PipelineInput|
|---------------|--------|--------|-------------|
|`[IDictionary]`|false   |named   |false        |



#### **Option**

The regular expression options, by default, IgnoreCase and IgnorePatternWhitespace



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






|Type            |Required|Position|PipelineInput|Aliases|
|----------------|--------|--------|-------------|-------|
|`[RegexOptions]`|false   |named   |false        |Options|



#### **RightToLeft**

If set, will go from right to left, instead of left to right.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |



#### **Timeout**

The match timeout.  By default, five seconds.






|Type        |Required|Position|PipelineInput|
|------------|--------|--------|-------------|
|`[TimeSpan]`|false   |named   |false        |



#### **CaseSensitive**

Indicates that the cmdlet makes matches case-sensitive. By default, matches are not case-sensitive.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |



#### **Pattern**

A regular expression.
While we don't want to restrict the steps here, we _do_ want to be able to suggest steps that are built-in.






|Type      |Required|Position|PipelineInput        |Aliases   |
|----------|--------|--------|---------------------|----------|
|`[String]`|false   |named   |true (ByPropertyName)|Expression|



#### **Generator**

A pattern generator.  This script will generate a regular expression






|Type           |Required|Position|PipelineInput|
|---------------|--------|--------|-------------|
|`[ScriptBlock]`|false   |named   |false        |



#### **ExpressionParameter**

Named parameters for the regular expression.  These are only valid if the regex is a Generator.






|Type           |Required|Position|PipelineInput|Aliases             |
|---------------|--------|--------|-------------|--------------------|
|`[IDictionary]`|false   |named   |false        |ExpressionParameters|



#### **ExpressionArgumentList**

A list of arguments.  These are only valid if the regex is using a Generator script.






|Type          |Required|Position|PipelineInput|Aliases                               |
|--------------|--------|--------|-------------|--------------------------------------|
|`[PSObject[]]`|false   |named   |false        |ExpressionArguments<br/>ExpressionArgs|





---


### Outputs
* [Text.RegularExpressions.Match](https://learn.microsoft.com/en-us/dotnet/api/System.Text.RegularExpressions.Match)


* [String](https://learn.microsoft.com/en-us/dotnet/api/System.String)


* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)






---


### Syntax
```PowerShell
Use-RegEx [[-Match] <String[]>] [-IsMatch] [-Measure] [-Count <Int32>] [-StartAt <Int32>] [-Remove] [-Replace <String>] [-Scan] [-ReplaceIf <IDictionary>] [-ReplaceEvaluator <ScriptBlock>] [-Split] [-Until] [-IncludeMatch] [-IncludeInputObject] [-Trim] [-Extract] [-PSTypeName <String>] [-Transform <String>] [-Coerce <IDictionary>] [-Where <ScriptBlock>] [-If <IDictionary>] [-Option {None | IgnoreCase | Multiline | ExplicitCapture | Compiled | Singleline | IgnorePatternWhitespace | RightToLeft | ECMAScript | CultureInvariant}] [-RightToLeft] [-Timeout <TimeSpan>] [-CaseSensitive] [-Pattern <String>] [-Generator <ScriptBlock>] [-ExpressionParameter <IDictionary>] [-ExpressionArgumentList <PSObject[]>] [<CommonParameters>]
```
```PowerShell
Use-RegEx [-Match] <String[]> [-IsMatch] [-Measure] [-Count <Int32>] [-StartAt <Int32>] [-Remove] [-Replace <String>] [-Scan] [-ReplaceIf <IDictionary>] [-ReplaceEvaluator <ScriptBlock>] [-Split] [-Until] [-IncludeMatch] [-IncludeInputObject] [-Trim] [-Extract] [-PSTypeName <String>] [-Transform <String>] [-Coerce <IDictionary>] [-Where <ScriptBlock>] [-If <IDictionary>] [-Option {None | IgnoreCase | Multiline | ExplicitCapture | Compiled | Singleline | IgnorePatternWhitespace | RightToLeft | ECMAScript | CultureInvariant}] [-RightToLeft] [-Timeout <TimeSpan>] [-CaseSensitive] [-Generator <ScriptBlock>] [-ExpressionParameter <IDictionary>] [-ExpressionArgumentList <PSObject[]>] [<CommonParameters>]
```
