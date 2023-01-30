Set-RegEx
---------
### Synopsis
Sets a Regular Expression

---
### Description

Sets Regular Expressions to a .regex.txt file

---
### Related Links
* [Use-RegEx](Use-RegEx.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
New-RegEx -Name Digits -CharacterClass Digit -Repeat |
    Set-RegEx
```

---
### Parameters
#### **Pattern**

The regular expression.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **Name**

The name of the regular expression.  If not provided, this can be inferred if the pattern starts with a capture






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|



---
#### **Description**

The description






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



---
#### **Path**

The path to the file.  If this is not provided, it will save regular expressions to the user's Irregular module path.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|



---
#### **Temporary**

If set, will not save the regular expression to disk.  Instead, it will alter the in-memory RegEx library.
To use the alias immediately, call Set-RegEx with the . operator (e.g. . Set-Regex -Pattern '\s+' -Name Whitespace -Temporary)






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
#### **TimeOut**

The timeout for the regular expression.
This will only be used if the expression is temporary.
By default, this is 5 seconds






|Type        |Required|Position|PipelineInput|
|------------|--------|--------|-------------|
|`[TimeSpan]`|false   |named   |false        |



---
#### **PassThru**

If set, will output created files or commands.
If using -Temporary, will output the created commands.
Otherwise, will output the created files.






|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |



---
#### **WhatIf**
-WhatIf is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-WhatIf is used to see what would happen, or return operations without executing them
#### **Confirm**
-Confirm is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-Confirm is used to -Confirm each operation.
    
If you pass ```-Confirm:$false``` you will not be prompted.
    
    
If the command sets a ```[ConfirmImpact("Medium")]``` which is lower than ```$confirmImpactPreference```, you will not be prompted unless -Confirm is passed.

---
### Outputs
* [Nullable](https://learn.microsoft.com/en-us/dotnet/api/System.Nullable)




---
### Syntax
```PowerShell
Set-RegEx [-Pattern] <String> [[-Name] <String>] [-Description <String>] [-Path <String>] [-Temporary] [-TimeOut <TimeSpan>] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```
---
