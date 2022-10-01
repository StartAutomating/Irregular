
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



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **FromModule**

If provided, will get regular expressions from any number of already imported modules.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:false



---
#### **Pattern**

One or more direct patterns to import



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **Name**

The Name of the Regular Expression.



> **Type**: ```[String[]]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **PassThru**

If set, will output the imported regular expressions.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



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


