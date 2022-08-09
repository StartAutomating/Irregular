$IrregularLoaded = Get-Module Irregular
if (-not $IrregularLoaded) {
    $IrregularLoaded = Get-ChildItem -Recurse -Filter "*.psd1" | 
        Where-Object Name -eq 'Irregular.psd1' | 
        Import-Module -Name { $_.FullName } -Force -PassThru
}
if ($IrregularLoaded) {
    "::notice title=ModuleLoaded::Irregular Loaded" | Out-Host
} else {
    "::error:: Irregular not loaded" |Out-Host
}
if ($IrregularLoaded) {
    Save-MarkdownHelp -Module $IrregularLoaded.Name -PassThru -SkipCommandType Alias
}
