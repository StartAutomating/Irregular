#requires -Module PSSVG


Push-Location ($PSScriptRoot | Split-Path)

$psChevron = 
    =<svg.symbol> -Id psChevron -Content @(
        =<svg.polygon> -Points (@(
            "40,20"
            "45,20"
            "60,50"
            "35,80"
            "32.5,80"
            "55,50"
        ) -join ' ')
    ) -ViewBox 100, 100 -PreserveAspectRatio $false


$assetsPath = Join-Path $pwd assets

=<svg> -ViewBox 300, 100 @(
    $psChevron

    =<svg.use> -Href '#psChevron' -Fill '#4488ff' -X 7.5% -Y 0% -Width 15% 
    =<svg.text> -X 50% -Y 50% -TextAnchor 'middle' -DominantBaseline 'middle' -Content @(
        =<svg.tspan> -Content "?<" -Rotate .5 -Dy .1em
        =<svg.tspan> -Content 'Irregular' -Rotate -1 -Dx -.25em -Dy -.1em
        =<svg.tspan> -Content '>' -Rotate .5 -Dx -.25em -Dy .1em
    ) -FontFamily 'sans-serif' -Fill '#4488ff' -FontSize 36   
) -OutputPath (Join-Path $assetsPath Irregular.svg)


Pop-Location