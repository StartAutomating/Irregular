Import-RegEx
------------
### Synopsis
Imports Regular Expressions

---
### Description

Imports saved Regular Expressions.

---
### Related Links
* [Use-RegEx](Use-RegEx.md)



* [New-RegEx](New-RegEx.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Import-RegEx # Imports Regex from Irregular and the current directory.
```

#### EXAMPLE 2
```PowerShell
Import-Regex -FromModule AnotherModule # Imports Regular Expressions stored in another module.
```

#### EXAMPLE 3
```PowerShell
Import-RegEx -Name NextWord
```

---
### Parameters
#### **FilePath**

The path to one or more files or folders containing regular expressions.
Files should be named $Name.regex.txt or $Name.regex.ps1






|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[String[]]`|false   |1       |true (ByPropertyName)|



---
#### **FromModule**

If provided, will get regular expressions from any number of already imported modules.






|Type        |Required|Position|PipelineInput|
|------------|--------|--------|-------------|
|`[String[]]`|false   |2       |false        |



---
#### **Pattern**

One or more direct patterns to import






|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[String[]]`|false   |3       |true (ByPropertyName)|



---
#### **Name**

The Name of the Regular Expression.






|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[String[]]`|false   |4       |true (ByPropertyName)|



---
#### **PassThru**

If set, will output the imported regular expressions.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |



---
### Outputs
* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)


* [Management.Automation.PSObject](https://learn.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSObject)




---
### Syntax
```PowerShell
Import-RegEx [[-FilePath] <String[]>] [[-FromModule] <String[]>] [[-Pattern] <String[]>] [[-Name] <String[]>] [-PassThru] [<CommonParameters>]
```
---
