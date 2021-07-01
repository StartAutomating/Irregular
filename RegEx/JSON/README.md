This directory contains regular expressions, generators, and RegEx source files for JSON.

### Regular Expressions

|Name|Description|
|-|-|
|[```?<JSON_List>```](List.regex.txt)|A JSON List|
|[```?<JSON_ListSeparator>```](ListSeparator.regex.txt)|Matches a JSON list separator|
|[```?<JSON_Number>```](Number.regex.txt)|Matches a JSON Number|
|[```?<JSON_PropertyName>```](PropertyName.regex.txt)|A property within a JSON string|
|[```?<JSON_String>```](String.regex.txt)|Matches a JSON string|
|[```?<JSON_Value>```](Value.regex.txt)|Matches a JSON Value.|

### Regular Expression Generators

|Name|Description|Parameters|
|-|--|-|
|[```?<JSON_ListItem>```](ListItem.regex.ps1)|Matches a JSON list item.  If no -ListIndex is provided, will match all items in the list    <BR/>|```-ListIndex <int>```|
|[```?<JSON_Property>```](Property.regex.ps1)|Matches a JSON property.  -PropertyName can be customized.<BR/>|```-PropertyName <string>```|