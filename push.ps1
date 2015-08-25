param(
    [alias('s')]
    [ValidateSet('VisualOnStaging', 'VisualOn')]
    [string]$Source = 'VisualOnStaging'
)

Get-ChildItem bin -File -Filter *.nupkg | % { nuget push $_.FullName -Source $Source }
