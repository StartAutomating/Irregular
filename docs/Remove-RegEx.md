Remove-RegEx
------------
### Synopsis
Removes Regular Expressions

---
### Description

Removes Regular Expressions that have been created.  
This will remove the associated file, any module sharing the Regex's name, and any dynamic aliases.

---
### Related Links
* [Get-RegEx](Get-RegEx.md)



* [Set-RegEx](Set-RegEx.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Remove-RegEx -Name MyRegEx
```

---
### Parameters
#### **Name**

The name of one or more regular expressions






|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[String[]]`|true    |1       |true (ByPropertyName)|



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
Remove-RegEx [-Name] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```
---
