$piecemealLoaded = Get-Module Piecemeal
if (-not $piecemealLoaded) {
    $piecemealLoaded = Get-ChildItem -Recurse -Filter "*.psd1" | Where-Object Name -like 'Piecemeal*' | Import-Module -Name { $_.FullName } -Force -PassThru
}
if ($piecemealLoaded) {
    "::notice title=ModuleLoaded::Piecemeal Loaded" | Out-Host
} else {
    "::error:: Piecemeal not loaded" |Out-Host
}
if ($piecemealLoaded) {
    Save-MarkdownHelp -Module $piecemealLoaded.Name -PassThru
}
