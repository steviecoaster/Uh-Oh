[cmdletBinding()]
param(
    [Parameter()]
    [Switch]
    $Build,
    
    [Parameter()]
    [Switch]
    $Test,

    [Parameter()]
    [Switch]
    $DeployToGallery,

    [Parameter()]
    [Switch]
    $Choco
)

process {

    $root = Split-Path -Parent $MyInvocation.MyCommand.Definition

    if (Test-Path "$root\Output") {
        Remove-Item "$root\Output\Uh-Oh\*.psm1" -Recurse -Force
    }

    if (Test-Path "$root\src\nuget\tools\Uh-Oh.zip"){
        Remove-Item "$root\src\nuget\tools\Uh-Oh.zip" -Force
    }


    switch ($true) {

        $Build {

            Get-ChildItem $root\src\public\*.ps1 | Foreach-Object { 
                Get-Content $_.FullName | Add-Content "$root\Output\Uh-Oh\Uh-Oh.psm1"
            }
            
            $manifest = Import-PowerShellDataFile "$root\Output\Uh-Oh\Uh-Oh.psd1"

            [version]$version = $Manifest.ModuleVersion
            # Add one to the build of the version number

            if(($Version.Build + 1) -eq 10){
                [version]$NewVersion = "{0}.{1}.{2}" -f $Version.Major, ($Version.Minor + 1), '0'
            } else { [version]$NewVersion = "{0}.{1}.{2}" -f $Version.Major, $Version.Minor, ($Version.Build + 1) }
            # Update the manifest file
            Update-ModuleManifest -Path "$root\Output\Uh-Oh\Uh-Oh.psd1" -ModuleVersion $NewVersion

            #Compress Module to zip file
            Compress-Archive -Path $root\Output\Uh-Oh -DestinationPath "$root\src\nuget\tools\Uh-Oh.zip"

        }
        $Test {

            Import-Module (Get-ChildItem $root -Recurse -Filter *.psd1).FullName
            Get-Command -module Uh-Oh
        }

        $DeployToGallery {}

        $Choco {
            
            $Nuspec = Get-ChildItem "$root\src\nuget" -recurse -filter *.nuspec
            (Get-Content "$($Nuspec.Fullname)").Replace('[[VERSION]]', "$NewVersion") | Set-Content "$Nuspec"

            choco pack $Nuspec.Fullname --output-directory $Nuspec.directory
            Get-ChildItem "$root\src\nuget" -recurse -filter *.nupkg | 
            Foreach-Object { 
                choco push $_.FullName -s https://push.chocolatey.org --api-key="'$($env:ChocoApiKey)'"
            }

        }
    }

}