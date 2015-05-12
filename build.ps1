param(
    [string]$Version = "1.0.0",
    [string]$Target = 'Build'
)


$BuildConfig = 'Release'
#$year = Get-Date -Format "yyyy"

$SolutionPath = Resolve-path Build.proj
$out = Join-Path (Resolve-Path .) bin

#region functions

function Invoke-MSBuild() {
param(
#        [Parameter(Mandatory=$true)]
#        [ValidateSet('v3.5', 'v4.5')]
#        [string] $tfv,
#        [string] $const = "TRACE"
    )
        
    $props = "Configuration=$BuildConfig;BUILD_NUMBER=$Version"

    $opts = @('/nologo', '/m', '/nr:false', "/v:m", "/t:$Target", "/p:$props", $SolutionPath);

    & msbuild $opts
}

#endregion

Invoke-MSBuild

#nuget pack VisualOn.Antlr4.Runtime.nuspec -OutputDirectory $out -Version "$version" -Properties "version=$version;year=$year"