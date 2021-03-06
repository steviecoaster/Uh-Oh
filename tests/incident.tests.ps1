$incidentCommands = Get-Command -Module Uh-Oh | Where-Object { $_.Name -match "Incident" }




Describe "Validating Working Online Help" {
    Foreach ($command in $incidentCommands) {

        $command.HelpUri

        It "$($command.Name) Online Help resolves" {
            (Invoke-WebRequest -Uri $command.HelpUri -UseBasicParsing).StatusCode | Should -Be 200
        }

    }
}