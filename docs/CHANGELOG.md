## 0.7.1:
* New Pattern:
  * ?<ANSI_Note> (Match ANSI VT520 note sequences) (Fixes #127) 
* Updated Patterns:
  * ?<FFMpeg_Progress>: Supporting duplicated / dropped frames (Fixes #128)
  * ?<Code_BuildVersion>: No longer matching if preceeded by punctuation (Fixes #127)
---

## 0.7.0:
* New Patterns:
  * ANSI
    * ?<ANSI_Code>  (Fixes #123)
    * ?<ANSI_Color> (Fixes #124)
    * ?<ANSI_DefaultColor>
    * ?<ANSI_4BitColor>
    * ?<ANSI_8BitColor>
    * ?<ANSI_24BitColor>
  * Mustache
    * ?<Mustache_Tag> (Fixes #121)
* New-Regex -LiteralCharacter '_' no longer escapes (Fixes #122)
* Reducing module size (excluding assets) (Fixes #118)
---

## 0.6.9:
* Adding ?<Markdown_Link> (Fixes #117)
* GitHub Action now prefers local bits (Fixes #111)
* Using PipeScript to enhance the repository experience (Fixes #119)
---

## 0.6.8:
* Added ?<CamelCaseSpace> (Fixes #114)
* Fixing ?<PowerShell_HelpField> (Fixes #108)
* Use-Regex:
  * Returning generator if -Match and -ExpressionParameter are not provided (Fixes #113)
* Automatically documenting module (Fixes #109)
* Automatically building module formatting (Fixes #112)
* Fixing Documentation (Fixes #115)
---

## 0.6.7:
* Command Improvements:
  * New-Regex:  Adding -ExcludeCharacterClass/-ExcludeLiteralCharacter/-ExcludeUnicodeCharacter (Fixing #104)
  * Use-Regex:  Adding -IncludeInputObject (Fixing #103)
  * Import-Regex:  Imported regular expressions are more likely to keep their path, even if they must be retried.
* Renaming Regex:  ?<BuildVersion> is now ?<Code_BuildVersion>
* GitHub Action Improvements:
  * Additional Tracing in GitHub Action.  Now ready for use.  (Fixing #93)
* Additional Improvements:
  * [SavedPatterns.md](SavedPatterns.md) now automatically updates.
---
## 0.6.6:
* New Regexes:
  * ?<C_Enum> (#98)
  * ?<C_Struct> (#99)
* Fixing Issues with whitespace in ?<FFMpeg_Progress> (#97)
---
## 0.6.5
* Renaming Regex: ?<IPV4Address> is now ?<Network_IPV4Address> (#90)
* New Regex: ?<Network_MACAddress> (#89)
* Use-Regex -Extract:  Now attempting [Timespan] before [DateTime] (#88)
---
## 0.6.4
* Renaming Write-RegEx to New-RegEx (#66) ** Write-RegEx will remain aliased until at least 0.7**
* Fixing Issue in Embedding (#82)
* Improving -Extract by auto-detecting data types (#81)
* ?<FFMpeg_Progress> - Fixing capture name (#80)
* Adding ?<FFMpeg_Configuration> (#83)
* Adding ?<FFMpeg_Stream> (#83)
* Adding ?<FFMpeg_Input> (#83)
* Adding ?<FFMpeg_Output> (#83)
* Adding ?<FFMpeg_Metadata> (#83)
---
## 0.6.3
New Regular Expressions:
* ?<CNC_GCode> (Fixes #76)
* OpenSCAD Expressions (Fixes #75)  
  * ?<OpenScad_Customization>
  * ?<OpenScad_Function>
  * ?<OpenScad_Include>
  * ?<OpenScad_Module>
  * ?<OpenScad_Parameter>
  * ?<OpenScad_Use>
* Additional Markdown Regexes
  * ?<Markdown_List> (Fixes #70)
  * ?<Markdown_YAMLHeader> (Fixes #71)
* Subtitle Regexes (Fixes #72)
  * ?<Subtitle_SRT>
  * ?<Subtitle_VTT>
---
## 0.6.2
New Regular Expressions:
* ?<Unix_Cron_Interval> (Fixes #67)
* ?<Unix_Duration> (Fixes #69)
---
## 0.6.1
* New Command:  Remove-RegEx (Fixes #62)
* Set-RegEx now supports -PassThru (Fixes #61)
* Set-RegEx now allows modifiers (Fixes #60)
* Use-RegEx now allows -Pattern to be directly provided, and supplies an ArgumentCompleter (Fixes #59)
Hat Tips: @JayKul, @LaurentDardenne
---
## 0.6
* JSON Regex Improvements
 * ?<JSON_Property> now can handle quotes
* Markdown Regexes:
 * ?<Markdown_Heading>
 * ?<Markdown_CodeBlock>
 * ?<Markdown_ThematicBreak>
* ?<REST_Variable> is now a generator.
---
## 0.5.9
* New RegEx:
  * ?<C_IfDef>
* New and Improved RegEx:
  * ?<JSON_Property> is now a generator (can specify -PropertyName)
  * ?<JSON_ListItem>
* Write-RegEx Improvements:
  * -Atomic now indents
  * -Or now indents
  * No longer makes -Then/-Else explicily non-capturing
---
## 0.5.8

* New RegEx:
  * ?<RegularExpression_Quantifier>
* Fixes to RegExes:
  * ?<REST_Variable> now allows variables to be embedded within <>s
---
## 0.5.7
* New RegExes:
  * ?<Security_AccessToken>
  * ?<Security_JWT>
* Fixes to Regexes:
  * ?<EmailAddress> now handles subdomains (#39)
  * ?<IPV4Address> will no longer match digits past the byte-range. (#38)
* New Capabilities:
  * Write-RegEx -DigitMax
---
## 0.5.6
* New RegExes:
  * ?<Code_SemanticVersion>
  * ?<FFmpeg_Progress>
  * ?<Keyboard_Shortcut>
  * ?<PowerShell_ParameterSet>
* Use-RegEx Improvements:
  * -Extract no longer includes .0 and the eponymous match group (unless that was the only group).
  * -Extract no longer includes .Match unless -IncludeMatch is passed.
  * -PSTypename can be used to decorate a match (implies -Extract)
* Write-RegEx Improvements:
  * Write-RegEx -Atomic -Or no longer overgroups
  * Write-RegEx -LiteralCharacter -Not now works as expected
  * Write-RegEx -Atomic -Min/-Max location fixed
---
## 0.5.5
* New Programming RegExes:
  * ?<PowerShell_Requires>
  * ?<C_Include>
  * ?<C_Define>
  * ?<CSharp_Using>
  * ?<CSharp_Namespace>

* Renaming ?<Namespace> to ?<Code_Namespace> [breaking]
* ?<REST_Variable>:
  * support for {/optionalsegments} (as seen in Git)
  * dollar sign now requires backtick (URL parameters can be named $, e.g. $top)
---
## 0.5.4
* Fixes in Irregular import (no longer producing a module per RegEx on import)
* Fixing a subtle bug in Write-RegEx -Until (was failing to match when no characters were between)
* New regex:
  * ?<HTML_LinkedData>, ?<HexColor>, ?<IPv4Address>
---
## 0.5.3
* Get/Export-Regex: Now supporting -As EmbeddedEngine (lambas) or -As Engine (smart aliases)
* Write-RegEx:  Added -UnicodeCharacter
* New regex:
  * ?<PowerShell_Region>
  * ?<Unix_Conf_Line>, ?<Unix_Conf_Section>, ?<Unix_Conf_File>, ?<Unix_Mount>, ?<Unix_FileSystemType>, ?<Unix_User>
* Updated RegEx Generators:
  * ?<MultilineComment> now supports OpenSCAD (.scad)
---
## 0.5.2
* Use-RegEx now matches within returns by default.
* Use-RegEx can -Scan to match after a given item
* Use-Regex breaking change:  -Parameter/-ArgumentList are now -ExpressionParameter/-ExpressionArgumentList
* Improving formatting (no longer showing match status, which was always 'true')
---
## 0.5.1
* Making Import-Regex support Regexes defined in other modules
* Allowing Import-Regex to import as lambdas
* Get/Export-Regex now include -As "Engine", which will export an embeddedable engine including an inline Import
* Write-Regex now supports -Modifier
* New Expressions:
  * ?<HexDigits>
  * ?<Git_Diff>
  * ?<Git_DiffHeader>
  * ?<Git_DiffRange>
  * ?<Git_Log>
  * ?<HTML_IDAttribute>
  * ?<HTML_DataAttribute>
  * ?<HTML_DataSet>
  * ?<HTML_ItemScope>

