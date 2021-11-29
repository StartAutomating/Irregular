@{
    ModuleVersion = '0.6.4'
    RootModule = 'Irregular.psm1'
    Description = 'Regular Expressions made Strangely Simple'
    FormatsToProcess = 'Irregular.format.ps1xml'
    TypesToProcess = 'Irregular.types.ps1xml'
    Guid = '39eb966d-7437-4e2c-abae-a496e933fb23'
    Author = 'James Brundage'
    Copyright = '2019-2021 Start-Automating'
    PrivateData = @{
        PSData = @{
            Tags = 'RegularExpressions', 'RegEx', 'Irregular', 'PatternMatching'
            ProjectURI = 'https://github.com/StartAutomating/Irregular'
            LicenseURI = 'https://github.com/StartAutomating/Irregular/blob/master/LICENSE'
            IconURI    = 'https://github.com/StartAutomating/Irregular/blob/master/Assets/Irregular_600_Square.png'
        }
        ReleaseNotes = @'
0.6.5
---
* Renaming Regex: ?<IPV4Address> is now ?<Network_IPV4Address> (#90)
* New Regex: ?<Network_MACAddress> (#89)
* Use-Regex -Extract:  Now attempting [Timespan] before [DateTime] (#88)

0.6.4
---
* Renaming Write-RegEx to New-RegEx (#66) ** Write-RegEx will remain aliased until at least 0.7**
* Fixing Issue in Embedding (#82)
* Improving -Extract by auto-detecting data types (#81)
* ?<FFMpeg_Progress> - Fixing capture name (#80)
* Adding ?<FFMpeg_Configuration> (#83)
* Adding ?<FFMpeg_Stream> (#83)
* Adding ?<FFMpeg_Input> (#83)
* Adding ?<FFMpeg_Output> (#83)
* Adding ?<FFMpeg_Metadata> (#83)

0.6.3
---
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


0.6.2
---
New Regular Expressions:
* ?<Unix_Cron_Interval> (Fixes #67)
* ?<Unix_Duration> (Fixes #69)

0.6.1
---
* New Command:  Remove-RegEx (Fixes #62)
* Set-RegEx now supports -PassThru (Fixes #61)
* Set-RegEx now allows modifiers (Fixes #60)
* Use-RegEx now allows -Pattern to be directly provided, and supplies an ArgumentCompleter (Fixes #59)
Hat Tips: @JayKul, @LaurentDardenne

0.6
---
* JSON Regex Improvements
** ?<JSON_Property> now can handle quotes
* Markdown Regexes:
** ?<Markdown_Heading>
** ?<Markdown_CodeBlock>
** ?<Markdown_ThematicBreak>
* ?<REST_Variable> is now a generator.


Additional Changes in [ChangeLog](CHANGELOG.md)
'@
    }
}

