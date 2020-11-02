$root = Split-Path -Parent $MyInvocation.MyCommand.Definition
$root = Split-Path -Parent $root
Import-Module "$root\Output\Uh-Oh\Uh-Oh.psd1" -Force

$incidentCommands = Get-Command -Module Uh-Oh | Where-Object { $_.Name -match "Incident" } | Select *

$incidentCommands


Describe "Validating Working Online Help" {
    Foreach ($command in $incidentCommands) {

        $command.HelpUri

        It "$($command.Name) Online Help resolves" {
            (Invoke-WebRequest -Uri $command.HelpUri -UseBasicParsing).StatusCode | Should -Be 200
        }

    }
}