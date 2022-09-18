### Irregular Patterns
Irregular includes 119 regular expressions
|Name|Description|IsGenerator|
|:---|:----------|:----------|
|[ANSI_24BitColor](/RegEx/ANSI/24BitColor.regex.txt)|Matches an ANSI 24-bit color|False|
|[ANSI_4BitColor](/RegEx/ANSI/4BitColor.regex.txt)|Matches an ANSI 3 or 4-bit color|False|
|[ANSI_8BitColor](/RegEx/ANSI/8BitColor.regex.txt)|Matches an ANSI 8 bit color|False|
|[ANSI_Code](/RegEx/ANSI/Code.regex.txt)|Matches an ANSI escape code|False|
|[ANSI_Color](/RegEx/ANSI/Color.regex.txt)|Matches an ANSI color|False|
|[ANSI_DefaultColor](/RegEx/ANSI/DefaultColor.regex.txt)|Matches an ANSI 24-bit color|False|
|[ANSI_Note](/RegEx/ANSI/Note.regex.txt)|Matches an ANSI VT520 Note|False|
|[ArithmeticOperator](/RegEx/ArithmeticOperator.regex.txt)|Simple Arithmetic Operators|False|
|[BalancedBrackets](/RegEx/BalancedBrackets.regex.txt)|Matches content in brackets, as long as it is balanced|False|
|[BalancedCode](/RegEx/BalancedCode.regex.ps1)|Matches code balanced by a [, {, or (|True|
|[BalancedCurlyBracket](/RegEx/BalancedCurlyBracket.regex.txt)|Matches content in {}, as long as it is balanced|False|
|[BalancedParenthesis](/RegEx/BalancedParenthesis.regex.txt)|Matches content in parenthesis, as long as it is balanced|False|
|[C_Define](/RegEx/C/Define.regex.txt)|Matches C/C++ #define|False|
|[C_Enum](/RegEx/C/Enum.regex.txt)|Matches a C/C++ Enum|False|
|[C_IfDef](/RegEx/C/IfDef.regex.txt)|Matches C/C++ #if/#ifdef/#ifndef .. #endif|False|
|[C_Include](/RegEx/C/Include.regex.txt)|Matches C/C++ #include|False|
|[C_Struct](/RegEx/C/Struct.regex.txt)|Matches a C/C++ Struct|False|
|[CamelCaseSpace](/RegEx/CamelCaseSpace.regex.txt)|Matches where a CamelCaseSpace would be|False|
|[CNC_GCode](/RegEx/CNC/GCode.regex.txt)|Matches GCode Instructions|False|
|[Code_BuildVersion](/RegEx/Code/BuildVersion.regex.txt)|Matches a build version|False|
|[Code_Namespace](/RegEx/Code/Namespace.regex.txt)|Finds a Namespace (captures the Name and the Content between {})|False|
|[Code_Region](/RegEx/Code/Region.regex.ps1)|Matches a #region #endregion pair. Returns the Name of the Region and the Content.|True|
|[Code_SemanticVersion](/RegEx/Code/SemanticVersion.regex.txt)|Matches a Semantic Version.  See [https://semver.org/](https://semver.org/).|False|
|[Colon](/RegEx/Colon.regex.txt)|Matches a literal colon|False|
|[CSharp_Namespace](/RegEx/CSharp/Namespace.regex.txt)|Matches a CSharp namespace|False|
|[CSharp_Using](/RegEx/CSharp/Using.regex.txt)|Matches a CSharp using keyword|False|
|[Decimals](/RegEx/Decimals.regex.txt)|Matching any series of decimals is deceptively complicated|False|
|[Digits](/RegEx/Digits.regex.txt)|Repeated Digits|False|
|[DoubleQuotedString](/RegEx/DoubleQuotedString.regex.ps1)|Matches a double quoted string, with an optional escape sequence (defaulting to backtick or backslash).|True|
|[EmailAddress](/RegEx/EmailAddress.regex.txt)|Matches an Email Address|False|
|[Equals](/RegEx/Equals.regex.txt)|A literal equal sign =|False|
|[FFmpeg_Configuration](/RegEx/FFmpeg/Configuration.regex.txt)|Matches FFMpeg configuration|False|
|[FFmpeg_Input](/RegEx/FFmpeg/Input.regex.txt)|Matches FFMpeg inputs|False|
|[FFmpeg_Metadata](/RegEx/FFmpeg/Metadata.regex.txt)|Matches FFMpeg metadata|False|
|[FFmpeg_Output](/RegEx/FFmpeg/Output.regex.txt)|Matches FFMpeg outputs|False|
|[FFmpeg_Progress](/RegEx/FFmpeg/Progress.regex.txt)|Matches Progress Lines in FFMpeg output|False|
|[FFmpeg_Stream](/RegEx/FFmpeg/Stream.regex.txt)|Matches FFMpeg streams|False|
|[GenericBalancingExpression](/RegEx/GenericBalancingExpression.regex.txt)|This expression matches content that is within "balanced" punctuation.<br/>It does not validate that each type of open/close punctuation is valid.<br/>Just that it any open punctuation is matched by closed punctuation.|False|
|[GetMarkupTag](/RegEx/GetMarkupTag.regex.ps1)|Gets one or more specific markup tags.  By default, anchor tags.|True|
|[Git_Diff](/RegEx/Git/Diff.regex.txt)|Matches Output from git diff|False|
|[Git_DiffHeader](/RegEx/Git/DiffHeader.regex.txt)|Matches Header information from the output of git diff|False|
|[Git_DiffRange](/RegEx/Git/DiffRange.regex.txt)|Matches a diff range|False|
|[Git_Log](/RegEx/Git/Log.regex.txt)|Matches Output from git log|False|
|[HexColor](/RegEx/HexColor.regex.txt)|Matches an RGB Hex Color|False|
|[HexDigits](/RegEx/HexDigits.regex.txt)|Matches one or more hexadecimal digits|False|
|[HTML_DataAttribute](/RegEx/HTML/DataAttribute.regex.txt)|Matches an HTML data attribute|False|
|[HTML_DataSet](/RegEx/HTML/DataSet.regex.txt)|Matches HTML5 start tags with data attributes|False|
|[HTML_EndTag](/RegEx/HTML/EndTag.regex.ps1)|Gets one or more end markup tags.  By default, gets end anchor tags.|True|
|[HTML_IDAttribute](/RegEx/HTML/IDAttribute.regex.txt)|Matches an HTML ID attribute|False|
|[HTML_ItemScope](/RegEx/HTML/ItemScope.regex.txt)|Matches HTML5 tags with an itemscope|False|
|[HTML_LinkedData](/RegEx/HTML/LinkedData.regex.txt)|Matches JSON Linked Data (JSON within HTML)|False|
|[HTML_StartOrEndTag](/RegEx/HTML/StartOrEndTag.regex.ps1)|Gets one or more start markup tags.  By default, gets start anchor tags.|True|
|[HTML_StartTag](/RegEx/HTML/StartTag.regex.ps1)|Gets one or more start markup tags.  By default, gets start anchor tags.|True|
|[JSON_List](/RegEx/JSON/List.regex.txt)|A JSON List|False|
|[JSON_ListItem](/RegEx/JSON/ListItem.regex.ps1)|Matches a JSON list item.  If no -ListIndex is provided, will match all items in the list    |True|
|[JSON_ListSeparator](/RegEx/JSON/ListSeparator.regex.txt)|Matches a JSON list separator|False|
|[JSON_Number](/RegEx/JSON/Number.regex.txt)|Matches a JSON Number|False|
|[JSON_Property](/RegEx/JSON/Property.regex.ps1)|Matches a JSON property.  -PropertyName can be customized.|True|
|[JSON_PropertyName](/RegEx/JSON/PropertyName.regex.txt)|A property within a JSON string|False|
|[JSON_String](/RegEx/JSON/String.regex.txt)|Matches a JSON string|False|
|[JSON_Value](/RegEx/JSON/Value.regex.txt)||False|
|[Keyboard_Shortcut](/RegEx/Keyboard/Shortcut.regex.txt)|Matches Keyboard Shortcuts<br/>Keyboard Shortcuts are a <Modifiers> followed by a Key|False|
|[LeadingWhitespace](/RegEx/LeadingWhitespace.regex.txt)|Matches zero or more whitespaces after the beginning of a line.|False|
|[LineEndsWithColon](/RegEx/LineEndsWithColon.regex.txt)|This returns lines that end with a colon|False|
|[LineStartOrEnd](/RegEx/LineStartOrEnd.regex.txt)|This will match either a line start or end.|False|
|[Markdown_CodeBlock](/RegEx/Markdown/CodeBlock.regex.ps1)|Matches a Markdown code block.  <br/>    <br/>    Code blocks can start/end with 3 or more backticks or tildas, or 4 indented whitespaces|True|
|[Markdown_Heading](/RegEx/Markdown/Heading.regex.ps1)|Matches Markdown Headings.  Can provide a -HeadingName, -HeadingLevel, and -IncludeContent.|True|
|[Markdown_Link](/RegEx/Markdown/Link.regex.ps1)|Matches a Markdown Link.  Can customize the link text and link url.|True|
|[Markdown_List](/RegEx/Markdown/List.regex.txt)|Matches a Markdown List|False|
|[Markdown_ThematicBreak](/RegEx/Markdown/ThematicBreak.regex.txt)|Matches markdown horizontal rules|False|
|[Markdown_YAMLHeader](/RegEx/Markdown/YAMLHeader.regex.txt)|Matches a Markdown YAML Header|False|
|[MultilineComment](/RegEx/MultilineComment.regex.ps1)|Matches Multline Comments from a variety of languages.<br/>Currently supported: PowerShell, C#, C++, JavaScript, Ruby, HTML, and XML<br/>When this generator is used with a piped in file, the extension will autodetect the format.<br/>If the format could not be autodetected, the match will always fail.|True|
|[Mustache_Tag](/RegEx/Mustache/Tag.regex.ps1)||True|
|[Network_IPv4Address](/RegEx/Network/IPv4Address.regex.txt)|Matches an IPv4 Address|False|
|[Network_MACAddress](/RegEx/Network/MACAddress.regex.txt)|Matches a MAC address|False|
|[NewLine](/RegEx/NewLine.regex.txt)|A newline (in either Windows (\r\n) or Unix (\n) form)|False|
|[NextColon](/RegEx/NextColon.regex.txt)|This returns the position of the next colon, but not the next colon itself.|False|
|[NextWord](/RegEx/NextWord.regex.txt)|Finds all repeated text that is not whitespace or punctuation.|False|
|[NumberAndExponent](/RegEx/NumberAndExponent.regex.txt)|Matches a decimal number with an exponent.|False|
|[NumberSign](/RegEx/NumberSign.regex.txt)|A number sign \#|False|
|[OpenSCAD_Customization](/RegEx/OpenSCAD/Customization.regex.txt)|Matches Potential Open SCAD Customizations|False|
|[OpenSCAD_Function](/RegEx/OpenSCAD/Function.regex.txt)|Matches Open SCAD Functions|False|
|[OpenSCAD_Include](/RegEx/OpenSCAD/Include.regex.txt)|Matches Open SCAD Modules|False|
|[OpenSCAD_Module](/RegEx/OpenSCAD/Module.regex.txt)|Matches Open SCAD Modules|False|
|[OpenSCAD_Parameter](/RegEx/OpenSCAD/Parameter.regex.txt)|Matches Potential Open SCAD Module Parameters|False|
|[OpenSCAD_Use](/RegEx/OpenSCAD/Use.regex.txt)|Matches Open SCAD Modules|False|
|[OptionalWhitespace](/RegEx/OptionalWhitespace.regex.txt)|This matches zero or more whitespace characters|False|
|[PHP_Tag](/RegEx/PHP/Tag.regex.txt)|Matches most PHP tags|False|
|[PII_Redacted_SSN](/RegEx/PII/Redacted_SSN.regex.txt)|Matches Unredacted Social Security Numbers|False|
|[PII_Unredacted_SSN](/RegEx/PII/Unredacted_SSN.regex.txt)|Matches Unredacted Social Security Numbers|False|
|[PowerShell_Attribute](/RegEx/PowerShell/Attribute.regex.txt)|Matches a PowerShell attribute declaration|False|
|[PowerShell_AttributeValue](/RegEx/PowerShell/AttributeValue.regex.txt)|This expression extracts the key/value pairs from a PowerShell attribute body (the content within parenthesis)|False|
|[PowerShell_HelpField](/RegEx/PowerShell/HelpField.regex.ps1)|Matches specific fields from inline help|True|
|[PowerShell_Invoke_Variable](/RegEx/PowerShell/Invoke_Variable.regex.txt)|Matches any time a variable is invoked (with the . or & operator)|False|
|[PowerShell_ParameterSet](/RegEx/PowerShell/ParameterSet.regex.txt)|Matches PowerShell ParameterSets (in [Parameter] and [CmdletBinding] attributes)|False|
|[PowerShell_Region](/RegEx/PowerShell/Region.regex.ps1)|Matches a PowerShell #region/#endregion pair.  Returns the Name of the Region and the Content.|True|
|[PowerShell_Requires](/RegEx/PowerShell/Requires.regex.txt)|Matches PowerShell #requires|False|
|[PowerShell_ScriptBlock](/RegEx/PowerShell/ScriptBlock.regex.txt)|Matches a PowerShell script block|False|
|[PowerShell_Variable](/RegEx/PowerShell/Variable.regex.txt)|Matches a PowerShell Variable|False|
|[Punctuation](/RegEx/Punctuation.regex.txt)|Matches any single or repeated punctuation.|False|
|[RegularExpression_Group](/RegEx/RegularExpression/Group.regex.txt)|Matches groups in a regular expression|False|
|[RegularExpression_Quantifier](/RegEx/RegularExpression/Quantifier.regex.txt)|Matches a quantifier|False|
|[REST_Variable](/RegEx/REST/Variable.regex.ps1)|Matches variables within a RESTful URL.  Variables can take several forms:<br/><br/>|True|
|[Security_AccessToken](/RegEx/Security/AccessToken.regex.ps1)|Matches Access Tokens.<br/><br/>    Access Tokens are single-line base64 strings that have more than -MinimumLength characters (default 40)|True|
|[Security_JWT](/RegEx/Security/JWT.regex.txt)|Matches a JSON Web Token (JWT)|False|
|[SingleQuotedString](/RegEx/SingleQuotedString.regex.ps1)|Matches a single quoted string, with an optional escape sequence (defaulting to two single quotes or a backslash).|True|
|[StartsWithCapture](/RegEx/StartsWithCapture.regex.txt)|Matches if the string starts with a named capture, and captures the FirstCaptureName|False|
|[Subtitle_SRT](/RegEx/Subtitle/SRT.regex.txt)|Matches a SubRip Subtitle|False|
|[Subtitle_VTT](/RegEx/Subtitle/VTT.regex.txt)|Matches a WebVTT Subtitle|False|
|[Tag](/RegEx/Tag.regex.txt)|This will match a balanced markup tag.|False|
|[TrueOrFalse](/RegEx/TrueOrFalse.regex.txt)|Matches the literal 'true' or 'false'|False|
|[Unix_Conf_File](/RegEx/Unix/Conf_File.regex.txt)|Matches Configuraiton File Content|False|
|[Unix_Conf_Line](/RegEx/Unix/Conf_Line.regex.txt)|Matches Lines in a .conf or .ini file.|False|
|[Unix_Conf_Section](/RegEx/Unix/Conf_Section.regex.txt)|Matches Sections in a .conf file.|False|
|[Unix_Cron_Interval](/RegEx/Unix/Cron_Interval.regex.txt)|Matches a Cron interval|False|
|[Unix_Duration](/RegEx/Unix/Duration.regex.txt)|Matches a Duration, defined in ISO 8601|False|
|[Unix_FileSystemType](/RegEx/Unix/FileSystemType.regex.txt)|Matches a File System Type (described in /proc/filesystems)|False|
|[Unix_Mount](/RegEx/Unix/Mount.regex.txt)|Matches a Unix Mount|False|
|[Unix_User](/RegEx/Unix/User.regex.txt)|Matches a User (described in /etc/passwd)|False|

