﻿@{
    ModuleVersion = '0.6'
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
0.6
---
* JSON Regex Improvements
** ?<JSON_Property> now can handle quotes
* Markdown Regexes:
** ?<Markdown_Heading>
** ?<Markdown_CodeBlock>
** ?<Markdown_ThematicBreak>
* ?<REST_Variable> is now a generator.

0.5.9
---
* New RegEx:
** ?<C_IfDef>
* New and Improved RegEx:
** ?<JSON_Property> is now a generator (can specify -PropertyName)
** ?<JSON_ListItem>
* Write-RegEx Improvements:
** -Atomic now indents
** -Or now indents
** No longer makes -Then/-Else explicily non-capturing

0.5.8
---
* New RegEx:
** ?<RegularExpression_Quantifier>
* Fixes to RegExes:
** ?<REST_Variable> now allows variables to be embedded within <>s
0.5.7
---
* New RegExes:
** ?<Security_AccessToken>
** ?<Security_JWT>
* Fixes to Regexes:
** ?<EmailAddress> now handles subdomains (#39)
** ?<IPV4Address> will no longer match digits past the byte-range. (#38)
* New Capabilities:
** Write-RegEx -DigitMax

0.5.6
---
* New RegExes:
** ?<Code_SemanticVersion>
** ?<FFmpeg_Progress>
** ?<Keyboard_Shortcut>
** ?<PowerShell_ParameterSet>
* Use-RegEx Improvements:
** -Extract no longer includes .0 and the eponymous match group (unless that was the only group).
** -Extract no longer includes .Match unless -IncludeMatch is passed.
** -PSTypename can be used to decorate a match (implies -Extract)
* Write-RegEx Improvements:
** Write-RegEx -Atomic -Or no longer overgroups
** Write-RegEx -LiteralCharacter -Not now works as expected
** Write-RegEx -Atomic -Min/-Max location fixed
0.5.5
----
* New Programming RegExes:
** ?<PowerShell_Requires>
** ?<C_Include>
** ?<C_Define>
** ?<CSharp_Using>
** ?<CSharp_Namespace>

Renaming ?<Namespace> to ?<Code_Namespace> [breaking]

?<REST_Variable>:
support for {/optionalsegments} (as seen in Git)
$ now requires backtick (URL parameters can be named $, e.g. $top)


0.5.4
----
* Fixes in Irregular import (no longer producing a module per RegEx on import)
* Fixing a subtle bug in Write-RegEx -Until (was failing to match when no characters were between)
* New regex:
** ?<HTML_LinkedData>, ?<HexColor>, ?<IPv4Address>


0.5.3
----
* Get/Export-Regex: Now supporting -As EmbeddedEngine (lambas) or -As Engine (smart aliases)
* Write-RegEx:  Added -UnicodeCharacter
* New regex:
** ?<PowerShell_Region>
** ?<Unix_Conf_Line>, ?<Unix_Conf_Section>, ?<Unix_Conf_File>, ?<Unix_Mount>, ?<Unix_FileSystemType>, ?<Unix_User>
* Updated RegEx Generators:
** ?<MultilineComment> now supports OpenSCAD (.scad)


0.5.2
---
* Use-RegEx now matches within returns by default.
* Use-RegEx can -Scan to match after a given item
* Use-Regex breaking change:  -Parameter/-ArgumentList are now -ExpressionParameter/-ExpressionArgumentList
* Improving formatting (no longer showing match status, which was always 'true')


0.5.1
---
* Making Import-Regex support Regexes defined in other modules
* Allowing Import-Regex to import as lambdas
* Get/Export-Regex now include -As "Engine", which will export an embeddedable engine including an inline Import
* Write-Regex now supports -Modifier
* New Expressions:
** ?<HexDigits>
** ?<Git_Diff>
** ?<Git_DiffHeader>
** ?<Git_DiffRange>
** ?<Git_Log>
** ?<HTML_IDAttribute>
** ?<HTML_DataAttribute>
** ?<HTML_DataSet>
** ?<HTML_ItemScope>
'@
    }
}
