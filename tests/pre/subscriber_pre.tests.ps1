$incidentCommands = Get-Command | Where-Object { $_.Name -match "StaytusSubscriber" }


Describe "Validating Working Online Help" {
    Foreach ($command in $incidentCommands) {
        It "$($command.Name) Online Help resolves" {
            (Invoke-WebRequest $command.HelpUri).StatusCode | Should -Be 200
        }
    }
}