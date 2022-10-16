@{
    ModuleVersion = '0.7.5'
    RootModule = 'Irregular.psm1'
    Description = 'Regular Expressions made Strangely Simple'
    FormatsToProcess = 'Irregular.format.ps1xml'
    TypesToProcess = 'Irregular.types.ps1xml'
    Guid = '39eb966d-7437-4e2c-abae-a496e933fb23'
    Author = 'James Brundage'
    Copyright = '2019-2021 Start-Automating'
    PrivateData = @{
        PSData = @{
            Tags = 'RegularExpressions', 'RegEx', 'Irregular', 'PatternMatching', 'PipeScript'
            ProjectURI = 'https://github.com/StartAutomating/Irregular'
            LicenseURI = 'https://github.com/StartAutomating/Irregular/blob/master/LICENSE'
            IconURI    = 'https://github.com/StartAutomating/Irregular/blob/master/Assets/Irregular_600_Square.png'        
            ReleaseNotes = @'
## 0.7.5:

* Added Patterns for Liquid:
  * ?<Liquid_Expression> (Fixes #153)
  * ?<Liquid_Tag> (Fixes #154)

---

## 0.7.4:
* ANSI Improvements:
  * Regenerated ?<ANSI_Color> (Fixes #150)
  * Added ?<ANSI_Cursor> (Fixes #151)

---

## 0.7.3:
* ANSI Improvements:
  * Fixed ?<ANSI_Style> (Fixes #143)
  * ?<ANSI_4BitColor> now supports bright ranges (Fixes #145)
  * ?<ANSI_8BitColor>/?<ANSI_24BitColor> now supports background colors (Fixes #144)
  * ?<ANSI_8BitColor>/?<ANSI_24BitColor> now supports underline colors (Fixes #146)

---

## 0.7.2:
* Lots More ANSI support:
  * ?<ANSI_Bold> (Fixes #131)
  * ?<ANSI_Blink> (Fixes #132)
  * ?<ANSI_Faint> (Fixes #133)
  * ?<ANSI_Hide> (Fixes #134)
  * ?<ANSI_Invert> (Fixes #135)
  * ?<ANSI_Italic> (Fixes #136)
  * ?<ANSI_Reset> (Fixes #137)
  * ?<ANSI_Strikethrough> (Fixes #138)
  * ?<ANSI_Underline> (Fixes #139)
  * ?<ANSI_Style> (Fixes #140)
  * ?<ANSI_Note>:  Fixing capture names (Fixes #130)

---

## 0.7.1:
* New Pattern:
  * ?<ANSI_Note> (Match ANSI VT520 / DECPS note sequences) (Fixes #127) 
* Updated Patterns:
  * ?<FFMpeg_Progress>: Supporting duplicated / dropped frames (Fixes #128)
  * ?<Code_BuildVersion>: No longer matching if preceeded by punctuation (Fixes #126)

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

Additional Changes in [ChangeLog](CHANGELOG.md)
'@
        }
    }
}

