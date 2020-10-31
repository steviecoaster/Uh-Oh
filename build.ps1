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
    $Deploy
)

process {

    $root = Split-Path -Parent $MyInvocation.MyCommand.Definition

    if(Test-Path "$root\Output"){
        Remove-Item $root\Output -Recurse -Force
    }

    $null = New-Item "$root\Output\Uh-Oh" -ItemType Directory

    switch ($true) {

        $Build {

            Get-ChildItem $root\src\public\*.ps1 | Foreach-Object { 
                Get-Content $_.FullName | Add-Content "$root\Output\Uh-Oh\Uh-Oh.psm1"
            }

            Copy-Item $root\src\*.psd1 -Destination "$root\Output\Uh-Oh"
        }
        $Test {}
        $Deploy {}
    }

}