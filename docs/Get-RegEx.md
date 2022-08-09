
Get-RegEx
---------
### Synopsis
Gets Regular Expressions

---
### Description

Gets saved Regular Expressions.

---
### Related Links
* [Use-RegEx](Use-RegEx.md)
* [New-RegEx](New-RegEx.md)
---
### Examples
#### EXAMPLE 1
```PowerShell
Get-RegEx
```

#### EXAMPLE 2
```PowerShell
Get-RegEx -Name NextWord
```

#### EXAMPLE 3
```PowerShell
@(Get-RegEx | # Gets all saved Regular Expressions as a Markdown table
    Sort-Object Name |
    ForEach-Object -Begin {
        '|Name|Description|IsGenerator|'
        '|:---|:----------|:----------|'
    } -Process {
        $desc = $_.Description -replace '[\[\{\(]', '\$0'
        $desc=  if ($desc) {$desc | ?<NewLine> -Replace '<br/>'} else  { ''}
        "|$($_.Name)|$desc|$($_.IsGenerator)|"
    }) -join [Environment]::NewLine
```

---
### Parameters
#### **Name**

The Name of the Regular Expression.



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |1      |true (ByPropertyName)|
---
#### **FilePath**

The path to one or more files or folders containing regular expressions.
Files should be named $Name.regex.txt



|Type            |Requried|Postion|PipelineInput        |
|----------------|--------|-------|---------------------|
|```[String[]]```|false   |2      |true (ByPropertyName)|
---
#### **FromModule**

If provided, will get regular expressions from any number of already imported modules.



|Type            |Requried|Postion|PipelineInput|
|----------------|--------|-------|-------------|
|```[String[]]```|false   |3      |false        |
---
#### **As**

How the expression will be returned.



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



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[String]```|false   |4      |false        |
---
#### **Noun**

If provided, will rename -RegEx commands with the provided -Noun.
This option is only valid when -As is Engine.
It prevents name conflicts with Irregular.



|Type          |Requried|Postion|PipelineInput|
|--------------|--------|-------|-------------|
|```[String]```|false   |5      |false        |
---
### Outputs
System.Management.Automation.PSObject


---
### Syntax
```PowerShell
Get-RegEx [[-Name] <String[]>] [[-FilePath] <String[]>] [[-FromModule] <String[]>] [[-As] <String>] [[-Noun] <String>] [<CommonParameters>]
```
---


