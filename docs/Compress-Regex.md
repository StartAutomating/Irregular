Compress-Regex
--------------

### Synopsis
Compresses Regular Expressions

---

### Description

Compresses a Regular Expression, removing all whitespace and comments.

This will make a regular expression much more difficult to read, and a bit shorter.

---

### Examples
> EXAMPLE 1

```PowerShell
New-Regex -Description "This is a description of a regex nobody will care about" |
    New-Regex -Name Width @(
        ?<Decimals>
    ) |
    New-Regex -Name Height @(
        ?<Decimals>
    ) |  Compress-Regex
```

---

### Parameters
#### **Regex**
The regular expression to compress.

|Type     |Required|Position|PipelineInput                 |Aliases                                     |
|---------|--------|--------|------------------------------|--------------------------------------------|
|`[Regex]`|true    |1       |true (ByValue, ByPropertyName)|RegularExpression<br/>Pattern<br/>Expression|

#### **MatchTimeout**
The Match Timeout.
By default, this value will be carried over from the -RegEx.

|Type        |Required|Position|PipelineInput|
|------------|--------|--------|-------------|
|`[TimeSpan]`|false   |named   |false        |

---

### Syntax
```PowerShell
Compress-Regex [-Regex] <Regex> [-MatchTimeout <TimeSpan>] [<CommonParameters>]
```
