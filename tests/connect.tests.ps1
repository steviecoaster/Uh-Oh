$incidentCommands = Get-Command -Module Uh-Oh | Where-Object { $_.Name -match "Connect" }


Describe "Online Help Tests" {
    Foreach ($command in $incidentCommands) {
        It "$($command.Name) Online Help resolves" {
            (Invoke-WebRequest $command.HelpUri).StatusCode | Should -Be 200
        }
    }
}


Describe -Name 'Connect-StaytusServer Tests' -Fixture {

    Context 'Verifying connection function' {

        It 'Credential is the right type' {

            $Credential | Should -BeOfType "System.Management.Automation.PSCredential"

        }

        It 'Accepts a PSCredential Object' {
            # Act
            { Connect-StaytusServer -StaytusServer staytus.contoso.com -Credential $Credential } | Should -Not -Throw
            # Assert
        }
        
    }
}