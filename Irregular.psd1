@{
    ModuleVersion = '0.7.9'
    RootModule = 'Irregular.psm1'
    Description = 'Regular Expressions made Strangely Simple'
    FormatsToProcess = 'Irregular.format.ps1xml'
    TypesToProcess = 'Irregular.types.ps1xml'
    Guid = '39eb966d-7437-4e2c-abae-a496e933fb23'
    Author = 'James Brundage'
    Copyright = '2019-2023 Start-Automating'
    PrivateData = @{
        PSData = @{
            Tags = 'RegularExpressions', 'RegEx', 'Irregular', 'PatternMatching', 'PipeScript'
            ProjectURI = 'https://github.com/StartAutomating/Irregular'
            LicenseURI = 'https://github.com/StartAutomating/Irregular/blob/master/LICENSE'
            IconURI    = 'https://github.com/StartAutomating/Irregular/blob/master/Assets/Irregular_600_Square.png'        
            ReleaseNotes = @'
## 0.7.9:

* Irregular Docker Support (#205,#206,#207)
  * `docker run --interactive --tty ghcr.io/startautomating/irregular`
* Irregular Repository Cleanup (#208, #209, #210, #211)
* Exporting $Irregular (#212)
* Mounting Irregular: (#213) 
* Simple Symbol Patterns
  * ?<Symbol> (#202)
  * ?<Symbol_Currency> (#214)
  * ?<Symbol_Math> (#203)
  
---

Full history in [CHANGELOG](https://github.com/StartAutomating/Irregular/blob/master/CHANGELOG.md)

> Like It? [Star It](https://github.com/StartAutomating/Irregular)
> Love It? [Support It](https://github.com/sponsors/StartAutomating)
'@
        }
        ScriptTypes = @{
            RegExGenerator = @{
                Pattern = '\.regex\.ps1$'
            }
            RegExSource = @{
                Pattern = '\.regex\.source\.ps1$'
            }
        }
        ApplicationTypes = @{
            RegExFile = @{
                Pattern ='\.regex\.txt'
            }
        }
    }
}

