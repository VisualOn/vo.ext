
Get-ChildItem bin -File -Filter *.nupkg | % { nuget push $_.FullName -Source VisualOnExternals }