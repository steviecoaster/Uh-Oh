$incidentCommands = Get-Command | Where-Object { $_.Name -match "StaytusIncident" } | Select *

$incidentCommands


Describe "Validating Working Online Help" {
    Foreach ($command in $incidentCommands) {

        $command.HelpUri

        It "$($command.Name) Online Help resolves" {
            (Invoke-WebRequest -Uri $command.HelpUri -UseBasicParsing).StatusCode | Should -Be 200
        }

    }
}