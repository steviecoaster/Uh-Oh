$incidentCommands = Get-Command -Module Uh-Oh | Where-Object { $_.Name -match "Subscriber" }


Describe "Validating Working Online Help" {
    Foreach ($command in $incidentCommands) {
        It "$($command.Name) Online Help resolves" {
            (Invoke-WebRequest $command.HelpUri).StatusCode | Should -Be 200
        }
    }
}