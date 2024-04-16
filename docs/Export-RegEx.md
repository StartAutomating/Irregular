Export-RegEx
------------

### Synopsis
Exports a RegEx

---

### Description

Exports one or more Regular Expressions

---

### Related Links
* [Import-RegEx](Import-RegEx.md)

* [Set-RegEx](Set-RegEx.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Export-RegEx -Name Digits, Decimals -Path $home\MyRegExs
```
> EXAMPLE 2

```PowerShell
Export-RegEx -Name Digits, Decimals -As Script # Creates a script that embedes the expressions and Use-RegEx
```

---

### Parameters
#### **Name**
The name of the regular expression.  If not provided, this can be inferred if the pattern starts with a capture

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[String[]]`|false   |1       |true (ByPropertyName)|

#### **Path**
The export path.
If this is not provided, it will export regular expressions to the user's Irregular module path.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **As**
How the expression will be exported.
Valid Values:

* Metadata
* File
* Pattern
* Hashtable
* String
* Variable
* Alias
* Script
* Lambda
* Engine
* Embedded

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |3       |false        |

#### **Noun**
If provided, will rename -RegEx commands with the provided -Noun.
This option is only valid when -As is Engine.
It prevents name conflicts with Irregular.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |4       |false        |

#### **WhatIf**
-WhatIf is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-WhatIf is used to see what would happen, or return operations without executing them
#### **Confirm**
-Confirm is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-Confirm is used to -Confirm each operation.

If you pass ```-Confirm:$false``` you will not be prompted.

If the command sets a ```[ConfirmImpact("Medium")]``` which is lower than ```$confirmImpactPreference```, you will not be prompted unless -Confirm is passed.

---

### Notes
When exporting as a script, Use-RegEx is renamed to UseRegex.
This enables embedding the core of Irregular and your Regular Expressions into a module while making it easy to avoid exporting Irregular.

To use this within a module, make sure your module explicitly exports commands, or exports with a wildcard like '*-*'.

---

### Syntax
```PowerShell
Export-RegEx [[-Name] <String[]>] [[-Path] <String>] [[-As] <String>] [[-Noun] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
