### Irregular Patterns
|Name|Description|IsGenerator|
|:---|:----------|:----------|
|ArithmeticOperator|Simple Arithmetic Operators|False|
|BalancedBrackets|Matches content in brackets, as long as it is balanced|False|
|BalancedCode|Matches code balanced by a [, {, or (|True|
|BalancedCurlyBracket|Matches content in {}, as long as it is balanced|False|
|BalancedParenthesis|Matches content in parenthesis, as long as it is balanced|False|
|BuildVersion|Matches a build version|False|
|C_Define|Matches C/C++ #define|False|
|C_Enum|Matches a C/C++ Enum|False|
|C_IfDef|Matches C/C++ #if/#ifdef/#ifndef .. #endif|False|
|C_Include|Matches C/C++ #include|False|
|C_Struct|Matches a C/C++ Struct|False|
|CNC_GCode|Matches GCode Instructions|False|
|Code_Namespace|Finds a Namespace (captures the Name and the Content between {})|False|
|Code_Region|Matches a #region #endregion pair. Returns the Name of the Region and the Content.|True|
|Code_SemanticVersion|Matches a Semantic Version.  See [https://semver.org/](https://semver.org/).|False|
|Colon|Matches a literal colon|False|
|CSharp_Namespace|Matches a CSharp namespace|False|
|CSharp_Using|Matches a CSharp using keyword|False|
|Decimals|Matching any series of decimals is deceptively complicated|False|
|Digits|Repeated Digits|False|
|DoubleQuotedString|Matches a double quoted string, with an optional escape sequence (defaulting to backtick or backslash).|True|
|EmailAddress|Matches an Email Address|False|
|Equals|A literal equal sign =|False|
|FFmpeg_Configuration|Matches FFMpeg configuration|False|
|FFmpeg_Input|Matches FFMpeg inputs|False|
|FFmpeg_Metadata|Matches FFMpeg metadata|False|
|FFmpeg_Output|Matches FFMpeg outputs|False|
|FFmpeg_Progress|Matches Progress Lines in FFMpeg output|False|
|FFmpeg_Stream|Matches FFMpeg streams|False|
|GenericBalancingExpression|This expression matches content that is within "balanced" punctuation.<br/>It does not validate that each type of open/close punctuation is valid.<br/>Just that it any open punctuation is matched by closed punctuation.|False|
|GetMarkupTag|Gets one or more specific markup tags.  By default, anchor tags.|True|
|Git_Diff|Matches Output from git diff|False|
|Git_DiffHeader|Matches Header information from the output of git diff|False|
|Git_DiffRange|Matches a diff range|False|
|Git_Log|Matches Output from git log|False|
|HexColor|Matches an RGB Hex Color|False|
|HexDigits|Matches one or more hexadecimal digits|False|
|HTML_DataAttribute|Matches an HTML data attribute|False|
|HTML_DataSet|Matches HTML5 start tags with data attributes|False|
|HTML_EndTag|Gets one or more end markup tags.  By default, gets end anchor tags.|True|
|HTML_IDAttribute|Matches an HTML ID attribute|False|
|HTML_ItemScope|Matches HTML5 tags with an itemscope|False|
|HTML_LinkedData|Matches JSON Linked Data (JSON within HTML)|False|
|HTML_StartOrEndTag|Gets one or more start markup tags.  By default, gets start anchor tags.|True|
|HTML_StartTag|Gets one or more start markup tags.  By default, gets start anchor tags.|True|
|JSON_List|A JSON List|False|
|JSON_ListItem|Matches a JSON list item.  If no -ListIndex is provided, will match all items in the list    |True|
|JSON_ListSeparator|Matches a JSON list separator|False|
|JSON_Number|Matches a JSON Number|False|
|JSON_Property|Matches a JSON property.  -PropertyName can be customized.|True|
|JSON_PropertyName|A property within a JSON string|False|
|JSON_String|Matches a JSON string|False|
|JSON_Value||False|
|Keyboard_Shortcut|Matches Keyboard Shortcuts<br/>Keyboard Shortcuts are a <Modifiers> followed by a Key|False|
|LeadingWhitespace|Matches zero or more whitespaces after the beginning of a line.|False|
|LineEndsWithColon|This returns lines that end with a colon|False|
|LineStartOrEnd|This will match either a line start or end.|False|
|Markdown_CodeBlock|Matches a Markdown code block.  <br/>    <br/>    Code blocks can start/end with 3 or more backticks or tildas, or 4 indented whitespaces|True|
|Markdown_Heading|Matches Markdown Headings.  Can provide a -HeadingName, -HeadingLevel, and -IncludeContent.|True|
|Markdown_List|Matches a Markdown List|False|
|Markdown_ThematicBreak|Matches markdown horizontal rules|False|
|Markdown_YAMLHeader|Matches a Markdown YAML Header|False|
|MultilineComment|Matches Multline Comments from a variety of languages.<br/>Currently supported: PowerShell, C#, C++, JavaScript, Ruby, HTML, and XML<br/>When this generator is used with a piped in file, the extension will autodetect the format.<br/>If the format could not be autodetected, the match will always fail.|True|
|Network_IPv4Address|Matches an IPv4 Address|False|
|Network_MACAddress|Matches a MAC address|False|
|NewLine|A newline (in either Windows (\r\n) or Unix (\n) form)|False|
|NextColon|This returns the position of the next colon, but not the next colon itself.|False|
|NextWord|Finds all repeated text that is not whitespace or punctuation.|False|
|NumberAndExponent|Matches a decimal number with an exponent.|False|
|NumberSign|A number sign \#|False|
|OpenSCAD_Customization|Matches Potential Open SCAD Customizations|False|
|OpenSCAD_Function|Matches Open SCAD Functions|False|
|OpenSCAD_Include|Matches Open SCAD Modules|False|
|OpenSCAD_Module|Matches Open SCAD Modules|False|
|OpenSCAD_Parameter|Matches Potential Open SCAD Module Parameters|False|
|OpenSCAD_Use|Matches Open SCAD Modules|False|
|OptionalWhitespace|This matches zero or more whitespace characters|False|
|PHP_Tag|Matches most PHP tags|False|
|PII_Redacted_SSN|Matches Unredacted Social Security Numbers|False|
|PII_Unredacted_SSN|Matches Unredacted Social Security Numbers|False|
|PowerShell_Attribute|Matches a PowerShell attribute declaration|False|
|PowerShell_AttributeValue|This expression extracts the key/value pairs from a PowerShell attribute body (the content within parenthesis)|False|
|PowerShell_Function|Matches PowerShell functions|False|
|PowerShell_HelpField|Matches specific fields from inline help|True|
|PowerShell_Invoke_Variable|Matches any time a variable is invoked (with the . or & operator)|False|
|PowerShell_ParameterSet|Matches PowerShell ParameterSets (in [Parameter] and [CmdletBinding] attributes)|False|
|PowerShell_Region|Matches a PowerShell #region/#endregion pair.  Returns the Name of the Region and the Content.|True|
|PowerShell_Requires|Matches PowerShell #requires|False|
|PowerShell_ScriptBlock|Matches a PowerShell script block|False|
|PowerShell_Variable|Matches a PowerShell Variable|False|
|Punctuation|Matches any single or repeated punctuation.|False|
|RegularExpression_Group|Matches groups in a regular expression|False|
|RegularExpression_Quantifier|Matches a quantifier|False|
|REST_Variable|Matches variables within a RESTful URL.  Variables can take several forms:<br/><br/>|True|
|Security_AccessToken|Matches Access Tokens.<br/><br/>    Access Tokens are single-line base64 strings that have more than -MinimumLength characters (default 40)|True|
|Security_JWT|Matches a JSON Web Token (JWT)|False|
|SingleQuotedString|Matches a single quoted string, with an optional escape sequence (defaulting to two single quotes or a backslash).|True|
|StartsWithCapture|Matches if the string starts with a named capture, and captures the FirstCaptureName|False|
|Subtitle_SRT|Matches a SubRip Subtitle|False|
|Subtitle_VTT|Matches a WebVTT Subtitle|False|
|Tag|This will match a balanced markup tag.|False|
|TrueOrFalse|Matches the literal 'true' or 'false'|False|
|Unix_Conf_File|Matches Configuraiton File Content|False|
|Unix_Conf_Line|Matches Lines in a .conf or .ini file.|False|
|Unix_Conf_Section|Matches Sections in a .conf file.|False|
|Unix_Cron_Interval|Matches a Cron interval|False|
|Unix_Duration|Matches a Duration, defined in ISO 8601|False|
|Unix_FileSystemType|Matches a File System Type (described in /proc/filesystems)|False|
|Unix_Mount|Matches a Unix Mount|False|
|Unix_User|Matches a User (described in /etc/passwd)|False|
