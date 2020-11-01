$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition
$moduleName = 'Uh-Oh' # this may be different from the package name and different case
$moduleVersion = $env:ChocolateyPackageVersion  # this may change so keep this here
$savedParamsPath = Join-Path $toolsDir -ChildPath 'parameters.saved'

# module may already be installed outside of Chocolatey
Remove-Module -Name $moduleName -Force -ErrorAction SilentlyContinue

# remove the saved parameters file if it exists
if (Test-Path -Path $savedParamsPath) {
    Remove-Item -Path $savedParamsPath -Force
}

$sourcePath = Join-Path -Path $toolsDir -ChildPath "$modulename.zip"

    $destinationPath = Join-Path -Path $env:ProgramFiles -ChildPath "PowerShell\Modules\$moduleName\$moduleVersion"

    Write-Verbose "Installing '$modulename' to '$destinationPath'."

    # check destination path exists and create if not
    if (Test-Path -Path $destinationPath) {
        $null = New-Item -Path $destinationPath -ItemType Directory -Force
    }

    Get-ChocolateyUnzip -FileFullPath $sourcePath -Destination $destinationPath -PackageName $moduleName

    # save the locations where the module was installed so we can uninstall it
    Add-Content -Path $savedParamsPath -Value $destinationPath

# cleanup the module from the Chocolatey $toolsDir folder
Remove-Item -Path $sourcePath -Force -Recurse