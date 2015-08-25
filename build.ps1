param(
    [ValidateSet('Build', 'Pack', 'Clean')]
    [string]$Target = 'Build',
    [ValidatePattern("\d+\.\d+\.\d+(-\w*)?")]
    [string]$Version = "1.3.0"
)


$BuildConfig = 'Release'
#$year = Get-Date -Format "yyyy"

$SolutionPath = Resolve-path Build.proj
$out = Join-Path (Resolve-Path .) bin

#region functions

function Get-MsBuild
{
    $msbuilds = @('14.0', '12.0', '4.0')

    foreach($ver in $msbuilds)
    {
        $r = ('HKLM:\SOFTWARE\Microsoft\MSBuild\ToolsVersions\{0}' -f $ver)
        if(Test-Path $r)
        {
            $p = $r | Get-ItemProperty -Name 'MSBuildToolsPath' | Select-Object -ExpandProperty 'MSBuildToolsPath'
            return "$p\msbuild.exe"
        }
    }

    throw "MsBuild not found"
}

function Invoke-MSBuild() {
param(
#        [Parameter(Mandatory=$true)]
#        [ValidateSet('v3.5', 'v4.5')]
#        [string] $tfv,
#        [string] $const = "TRACE"
    )

    $props = "Configuration=$BuildConfig;BUILD_NUMBER=$Version"

    $opts = @('/nologo', '/m', '/nr:false', "/v:m", "/t:$Target", "/p:$props", $SolutionPath);

    & (Get-MsBuild) $opts
}

#endregion

Invoke-MSBuild

#nuget pack VisualOn.Antlr4.Runtime.nuspec -OutputDirectory $out -Version "$version" -Properties "version=$version;year=$year"
