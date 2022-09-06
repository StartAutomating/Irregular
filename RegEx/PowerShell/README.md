This directory contains regular expressions to help parse PowerShell.

It should be noted that these regular expressions _are not_ a perfect parser of PowerShell, nor are they designed to be.

They are designed to work in _most_ scenarios and to offer an alternative way to information about a PowerShell script without loading it into memory as a ```[ScriptBlock]```.


|Name                                                      |Description                                                                                                   |IsGenerator|
|----------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|-----------|
|[?<PowerShell_Attribute>](Attribute.regex.txt)            |Matches a PowerShell attribute declaration                                                                    |False      |
|[?<PowerShell_AttributeValue>](AttributeValue.regex.txt)  |This expression extracts the key/value pairs from a PowerShell attribute body (the content within parenthesis)|False      |
|[?<PowerShell_HelpField>](HelpField.regex.ps1)            |Matches specific fields from inline help<br/>                                                                |True       |
|[?<PowerShell_Invoke_Variable>](Invoke_Variable.regex.txt)|Matches any time a variable is invoked (with the . or & operator)                                             |False      |
|[?<PowerShell_ParameterSet>](ParameterSet.regex.txt)      |Matches PowerShell ParameterSets (in [Parameter] and [CmdletBinding] attributes)                              |False      |
|[?<PowerShell_Region>](Region.regex.ps1)                  |Matches a PowerShell #region/#endregion pair.  Returns the Name of the Region and the Content.<br/>           |True       |
|[?<PowerShell_Requires>](Requires.regex.txt)              |Matches PowerShell #requires                                                                                  |False      |
|[?<PowerShell_ScriptBlock>](ScriptBlock.regex.txt)        |Matches a PowerShell script block                                                                             |False      |
|[?<PowerShell_Variable>](Variable.regex.txt)              |Matches a PowerShell Variable                                                                                 |False      |



